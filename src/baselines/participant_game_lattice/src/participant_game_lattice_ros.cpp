#include <pluginlib/class_list_macros.h>
#include "participant_game_lattice/participant_game_lattice_ros.h"

// register this planner as a BaseLocalPlanner plugin
PLUGINLIB_EXPORT_CLASS(participant_game_lattice::ParticipantGameLatticeROS, nav_core::BaseLocalPlanner)

namespace participant_game_lattice
{
ParticipantGameLatticeROS::ParticipantGameLatticeROS()
  : initialized_(false), size_x_(0), size_y_(0), charmap_(NULL), costmap_model_(NULL), planner_(NULL)
{
}

ParticipantGameLatticeROS::~ParticipantGameLatticeROS()
{
  freeMemory();

  if (planner_)
    delete planner_;
  if (costmap_model_)
    delete costmap_model_;
}

void ParticipantGameLatticeROS::freeMemory()
{
  if (charmap_)
  {
    for (int i = 0; i < size_x_; i++)
    {
      delete[] charmap_[i];
      charmap_[i] = NULL;
    }

    delete[] charmap_;
    charmap_ = NULL;
  }
}

void ParticipantGameLatticeROS::allocateMemory()
{
  assert(charmap_ == NULL);

  charmap_ = new unsigned char*[size_x_];
  for (int i = 0; i < size_x_; i++)
    charmap_[i] = new unsigned char[size_y_];
}

void ParticipantGameLatticeROS::initialize(std::string name, tf2_ros::Buffer* tf, costmap_2d::Costmap2DROS* costmap_ros)
{
  // check if the plugin is already initialized
  if (!initialized_)
  {
    name_ = name;
    // create Node Handle with name of plugin (as used in move_base for loading)
    ros::NodeHandle private_nh("~/" + name);

    // get parameters of BezierConfig via the nodehandle and override the default config
    cfg_.loadRosParamFromNodeHandle(private_nh);

    // init other variables
    tf_ = tf;
    costmap_ros_ = costmap_ros;
    costmap_ = costmap_ros_->getCostmap();  // locking should be done in MoveBase.

    costmap_model_ = new base_local_planner::CostmapModel(*costmap_);

    global_frame_ = costmap_ros_->getGlobalFrameID();
    cfg_.map_frame = global_frame_;
    robot_base_frame_ = costmap_ros_->getBaseFrameID();

    // Get footprint of the robot and minimum and maximum distance from the center of the robot to its footprint
    // vertices.
    footprint_spec_ = costmap_ros_->getRobotFootprint();
    costmap_2d::calculateMinAndMaxDistances(footprint_spec_, robot_inscribed_radius_, robot_circumscribed_radius);

    // init the odom helper to receive the robot's velocity from odom messages
    odom_helper_.setOdomTopic(cfg_.odom_topic);

    planner_ = new ParticipantGameLattice(costmap_model_, footprint_spec_, robot_inscribed_radius_,
                                      robot_circumscribed_radius, cfg_, private_nh);

    global_plan_pub_ = private_nh.advertise<nav_msgs::Path>("global_plan", 1);
    
    // set initialized flag
    initialized_ = true;

    ROS_DEBUG("bezier_local_planner plugin initialized.");
  }
  else
  {
    ROS_WARN("bezier_local_planner has already been initialized, doing nothing.");
  }
}

bool ParticipantGameLatticeROS::setPlan(const std::vector<geometry_msgs::PoseStamped>& orig_global_plan)
{
  // check if plugin is initialized
  if (!initialized_)
  {
    ROS_ERROR("bezier_local_planner has not been initialized, please call initialize() before using this planner");
    return false;
  }

  // store the global plan
  global_plan_.clear();
  global_plan_ = orig_global_plan;

  global_goal_ = global_plan_.back();

  return true;
}

bool ParticipantGameLatticeROS::computeVelocityCommands(geometry_msgs::Twist& cmd_vel)
{
  // check if plugin is initialized
  if (!initialized_)
  {
    ROS_ERROR("bezier_local_planner has not been initialized, please call initialize() before using this planner");
    return false;
  }

  // Get current robot pose
  geometry_msgs::PoseStamped robot_pose_stamped;
  costmap_ros_->getRobotPose(robot_pose_stamped);
  Pose2D robot_pose;
  robot_pose.x = robot_pose_stamped.pose.position.x;
  robot_pose.y = robot_pose_stamped.pose.position.y;
  robot_pose.theta = tf2::getYaw(robot_pose_stamped.pose.orientation);

  // Get current robot velocity
  geometry_msgs::PoseStamped robot_vel_tf;
  odom_helper_.getRobotVel(robot_vel_tf);
  Velocity robot_vel;
  robot_vel.v = robot_vel_tf.pose.position.x;
  robot_vel.omega = tf2::getYaw(robot_vel_tf.pose.orientation);

  // prune global plan to cut off parts of the past (spatially before the robot)
  pruneGlobalPlan(*tf_, robot_pose_stamped, global_plan_);

  // Transform global plan to the frame of interest (w.r.t. the local costmap)
  std::vector<geometry_msgs::PoseStamped> transformed_plan;
  int goal_idx;
  geometry_msgs::TransformStamped tf_plan_to_global;

  if (!transformGlobalPlan(*tf_, global_plan_, robot_pose_stamped, *costmap_, global_frame_,
                           cfg_.max_global_plan_lookahead_dist, transformed_plan, &goal_idx, &tf_plan_to_global))
  {
    ROS_WARN("Could not transform the global plan to the frame of the controller");
    return false;
  }

  // Return false if the transformed global plan is empty
  if (transformed_plan.empty())
  {
    ROS_WARN("Transformed plan is empty. Cannot determine a local plan.");
    return false;
  }

  // Overwrite goal orientation if needed
  double goal_theta = estimateLocalGoalOrientation(global_plan_, transformed_plan.back(), goal_idx, tf_plan_to_global);
  // overwrite/update goal orientation of the transformed plan with the actual goal (enable using the plan as
  // initialization)
  tf2::Quaternion q;
  q.setRPY(0, 0, goal_theta);
  tf2::convert(q, transformed_plan.back().pose.orientation);

  // overwrite/update start of the transformed plan with the actual robot position (allows using the plan as initial
  // trajectory)
  if (transformed_plan.size() == 1)  // plan only contains the goal
  {
    transformed_plan.insert(transformed_plan.begin(),
                            geometry_msgs::PoseStamped());  // insert start (not yet initialized)
  }
  transformed_plan.front() = robot_pose_stamped;  // update start

  // update distance map for obstacles
  unsigned int size_x = costmap_->getSizeInCellsX();
  unsigned int size_y = costmap_->getSizeInCellsY();
  double resolution = costmap_->getResolution();
  double origin_x = costmap_->getOriginX();
  double origin_y = costmap_->getOriginY();
  const unsigned char* charmap = costmap_->getCharMap();

  if (charmap_ == NULL || size_x_ != size_x || size_y_ != size_y)
  {
    freeMemory();

    size_x_ = size_x;
    size_y_ = size_y;

    allocateMemory();
  }

  for (int j = 0; j < size_y_; j++)
  {
    for (int i = 0; i < size_x_; i++)
      charmap_[i][j] = charmap[i + j * size_x_];
  }

  std::vector<Pose2D> reference_path;
  for (int i = 0; i < (int)transformed_plan.size(); i++)
  {
    double x = transformed_plan[i].pose.position.x;
    double y = transformed_plan[i].pose.position.y;
    double theta = tf2::getYaw(transformed_plan[i].pose.orientation);
    reference_path.push_back(Pose2D(x, y, theta));
  }

  // publish pruned global plan
  publishGlobalPlan(transformed_plan);

  Velocity planned_cmd_vel;
  bool success = planner_->computeVelocityCommands(robot_vel, robot_pose, reference_path, charmap_, size_x_, size_y_,
                                                   resolution, origin_x, origin_y, planned_cmd_vel);

  if (!success)
  {
    cmd_vel.linear.x = 0.0;
    cmd_vel.angular.z = 0.0;
    return false;
  }
  else
  {
    cmd_vel.linear.x = planned_cmd_vel.v;
    cmd_vel.angular.z = planned_cmd_vel.omega;
    return true;
  }
}

bool ParticipantGameLatticeROS::isGoalReached()
{
  // check if plugin is initialized
  if (!initialized_)
  {
    ROS_ERROR("bezier_local_planner has not been initialized, please call initialize() before using this planner");
    return false;
  }

  // Get current robot pose
  geometry_msgs::PoseStamped robot_pose;
  costmap_ros_->getRobotPose(robot_pose);

  double dx = robot_pose.pose.position.x - global_goal_.pose.position.x;
  double dy = robot_pose.pose.position.y - global_goal_.pose.position.y;
  if (hypot(dx, dy) < cfg_.xy_goal_tolerance)
  {
    ROS_INFO("GOAL Reached!");
    return true;
  }
  else
  {
    return false;
  }
}

bool ParticipantGameLatticeROS::pruneGlobalPlan(const tf2_ros::Buffer& tf, const geometry_msgs::PoseStamped& global_pose,
                                            std::vector<geometry_msgs::PoseStamped>& global_plan,
                                            double dist_behind_robot)
{
  if (global_plan.empty())
    return true;

  try
  {
    // transform robot pose into the plan frame (we do not wait here, since pruning not crucial, if missed a few times)
    geometry_msgs::TransformStamped global_to_plan_transform =
        tf.lookupTransform(global_plan.front().header.frame_id, global_pose.header.frame_id, ros::Time(0));
    geometry_msgs::PoseStamped robot;
    tf2::doTransform(global_pose, robot, global_to_plan_transform);

    double dist_thresh_sq = dist_behind_robot * dist_behind_robot;

    // iterate plan until a pose close the robot is found
    std::vector<geometry_msgs::PoseStamped>::iterator it = global_plan.begin();
    std::vector<geometry_msgs::PoseStamped>::iterator erase_end = it;
    while (it != global_plan.end())
    {
      double dx = robot.pose.position.x - it->pose.position.x;
      double dy = robot.pose.position.y - it->pose.position.y;
      double dist_sq = dx * dx + dy * dy;
      if (dist_sq < dist_thresh_sq)
      {
        erase_end = it;
        break;
      }
      ++it;
    }
    if (erase_end == global_plan.end())
      return false;

    if (erase_end != global_plan.begin())
      global_plan.erase(global_plan.begin(), erase_end);
  }
  catch (const tf::TransformException& ex)
  {
    ROS_DEBUG("Cannot prune path since no transform is available: %s\n", ex.what());
    return false;
  }

  return true;
}

bool ParticipantGameLatticeROS::transformGlobalPlan(
    const tf2_ros::Buffer& tf, const std::vector<geometry_msgs::PoseStamped>& global_plan,
    const geometry_msgs::PoseStamped& global_pose, const costmap_2d::Costmap2D& costmap,
    const std::string& global_frame, double max_plan_length, std::vector<geometry_msgs::PoseStamped>& transformed_plan,
    int* current_goal_idx, geometry_msgs::TransformStamped* tf_plan_to_global) const
{
  // this method is a slightly modified version of base_local_planner/goal_functions.h

  const geometry_msgs::PoseStamped& plan_pose = global_plan[0];

  transformed_plan.clear();

  try
  {
    if (global_plan.empty())
    {
      ROS_ERROR("Received plan with zero length");
      *current_goal_idx = 0;
      return false;
    }

    // get plan_to_global_transform from plan frame to global_frame
    geometry_msgs::TransformStamped plan_to_global_transform =
        tf.lookupTransform(global_frame, ros::Time(), plan_pose.header.frame_id, plan_pose.header.stamp,
                           plan_pose.header.frame_id, ros::Duration(cfg_.transform_tolerance));

    // let's get the pose of the robot in the frame of the plan
    geometry_msgs::PoseStamped robot_pose;
    tf.transform(global_pose, robot_pose, plan_pose.header.frame_id);

    // we'll discard points on the plan that are outside the local costmap
    double dist_threshold = std::max(costmap.getSizeInCellsX() * costmap.getResolution() / 2.0,
                                     costmap.getSizeInCellsY() * costmap.getResolution() / 2.0);
    dist_threshold *= 0.85;  // just consider 85% of the costmap size to better incorporate point obstacle that are
                             // located on the border of the local costmap

    int i = 0;
    double sq_dist_threshold = dist_threshold * dist_threshold;
    double sq_dist = 1e10;

    // we need to loop to a point on the plan that is within a certain distance of the robot
    bool robot_reached = false;
    for (int j = 0; j < (int)global_plan.size(); ++j)
    {
      double x_diff = robot_pose.pose.position.x - global_plan[j].pose.position.x;
      double y_diff = robot_pose.pose.position.y - global_plan[j].pose.position.y;
      double new_sq_dist = x_diff * x_diff + y_diff * y_diff;
      if (new_sq_dist > sq_dist_threshold)
        break;  // force stop if we have reached the costmap border

      if (robot_reached && new_sq_dist > sq_dist)
        break;

      if (new_sq_dist < sq_dist)  // find closest distance
      {
        sq_dist = new_sq_dist;
        i = j;
        if (sq_dist < 0.05)      // 2.5 cm to the robot; take the immediate local minima; if it's not the global
          robot_reached = true;  // minima, probably means that there's a loop in the path, and so we prefer this
      }
    }

    geometry_msgs::PoseStamped newer_pose;

    double plan_length = 0;  // check cumulative Euclidean distance along the plan

    // now we'll transform until points are outside of our distance threshold
    while (i < (int)global_plan.size() && sq_dist <= sq_dist_threshold &&
           (max_plan_length <= 0 || plan_length <= max_plan_length))
    {
      const geometry_msgs::PoseStamped& pose = global_plan[i];
      tf2::doTransform(pose, newer_pose, plan_to_global_transform);

      transformed_plan.push_back(newer_pose);

      double x_diff = robot_pose.pose.position.x - global_plan[i].pose.position.x;
      double y_diff = robot_pose.pose.position.y - global_plan[i].pose.position.y;
      sq_dist = x_diff * x_diff + y_diff * y_diff;

      // caclulate distance to previous pose
      if (i > 0 && max_plan_length > 0)
      {
        double dx = global_plan[i].pose.position.x - global_plan[i - 1].pose.position.x;
        double dy = global_plan[i].pose.position.y - global_plan[i - 1].pose.position.y;
        plan_length += hypot(dx, dy);
      }

      ++i;
    }

    // if we are really close to the goal (<sq_dist_threshold) and the goal is not yet reached (e.g. orientation error
    // >>0) the resulting transformed plan can be empty. In that case we explicitly inject the global goal.
    if (transformed_plan.empty())
    {
      tf2::doTransform(global_plan.back(), newer_pose, plan_to_global_transform);

      transformed_plan.push_back(newer_pose);

      // Return the index of the current goal point (inside the distance threshold)
      if (current_goal_idx)
        *current_goal_idx = int(global_plan.size()) - 1;
    }
    else
    {
      // Return the index of the current goal point (inside the distance threshold)
      if (current_goal_idx)
        *current_goal_idx = i - 1;  // subtract 1, since i was increased once before leaving the loop
    }

    // Return the transformation from the global plan to the global planning frame if desired
    if (tf_plan_to_global)
      *tf_plan_to_global = plan_to_global_transform;
  }
  catch (tf::LookupException& ex)
  {
    ROS_ERROR("No Transform available Error: %s\n", ex.what());
    return false;
  }
  catch (tf::ConnectivityException& ex)
  {
    ROS_ERROR("Connectivity Error: %s\n", ex.what());
    return false;
  }
  catch (tf::ExtrapolationException& ex)
  {
    ROS_ERROR("Extrapolation Error: %s\n", ex.what());
    if (global_plan.size() > 0)
      ROS_ERROR("Global Frame: %s Plan Frame size %d: %s\n", global_frame.c_str(), (unsigned int)global_plan.size(),
                global_plan[0].header.frame_id.c_str());

    return false;
  }

  return true;
}

double ParticipantGameLatticeROS::estimateLocalGoalOrientation(const std::vector<geometry_msgs::PoseStamped>& global_plan,
                                                           const geometry_msgs::PoseStamped& local_goal,
                                                           int current_goal_idx,
                                                           const geometry_msgs::TransformStamped& tf_plan_to_global,
                                                           int moving_average_length) const
{
  int n = (int)global_plan.size();

  // check if we are near the global goal already
  if (current_goal_idx > n - moving_average_length - 2)
  {
    if (current_goal_idx >= n - 1)  // we've exactly reached the goal
    {
      return tf2::getYaw(local_goal.pose.orientation);
    }
    else
    {
      tf2::Quaternion global_orientation;
      tf2::convert(global_plan.back().pose.orientation, global_orientation);
      tf2::Quaternion rotation;
      tf2::convert(tf_plan_to_global.transform.rotation, rotation);
      // TODO(roesmann): avoid conversion to tf2::Quaternion
      return tf2::getYaw(rotation * global_orientation);
    }
  }

  // reduce number of poses taken into account if the desired number of poses is not available
  moving_average_length =
      std::min(moving_average_length,
               n - current_goal_idx - 1);  // maybe redundant, since we have checked the vicinity of the goal before

  std::vector<double> candidates;
  geometry_msgs::PoseStamped tf_pose_k = local_goal;
  geometry_msgs::PoseStamped tf_pose_kp1;

  int range_end = current_goal_idx + moving_average_length;
  for (int i = current_goal_idx; i < range_end; ++i)
  {
    // Transform pose of the global plan to the planning frame
    tf2::doTransform(global_plan.at(i + 1), tf_pose_kp1, tf_plan_to_global);

    // calculate yaw angle
    candidates.push_back(std::atan2(tf_pose_kp1.pose.position.y - tf_pose_k.pose.position.y,
                                    tf_pose_kp1.pose.position.x - tf_pose_k.pose.position.x));

    if (i < range_end - 1)
      tf_pose_k = tf_pose_kp1;
  }

  return AverageAngles(candidates);
}

void ParticipantGameLatticeROS::publishGlobalPlan(const std::vector<geometry_msgs::PoseStamped>& global_plan)
{
  nav_msgs::Path gui_path;
  gui_path.header.frame_id = cfg_.map_frame;
  gui_path.header.stamp = ros::Time::now();
  gui_path.poses = global_plan;
  global_plan_pub_.publish(gui_path);
}

}  // namespace participant_game_lattice