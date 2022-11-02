#! /usr/bin/env python
# -*- coding: utf-8 -*-

'''
Author: yinuo Song
Email: 1349158395@qq.com
Description: a simple ROS node to control the mobile robot with MPC controller with (v,w) for Graduation Project
Last development: 2022.10.17
'''

import sys
print('---',sys.version)

import rospy
from api2python.srv import api_info
from nav_msgs.msg import OccupancyGrid
from nav_msgs.msg import Path
from geometry_msgs.msg import Twist
from geometry_msgs.msg import PoseStamped

from srv_preprocess import preprocess
from get_msg_person import Person_msg

import numpy as np
import cvxpy
from math import hypot, sin,cos,atan2
import matplotlib.pyplot as plt


GOAL_SPEED = 1.0
DELTA_D = 0.1
DT = 0.5
APPROACHING_DIS = 1.5*DT*GOAL_SPEED*1.2  # goal distance
ARRIVED_DIS = 0.5

MAX_V = 1.5 # maximum speed [m/s]
MIN_V = 0.0  # minimum speed [m/s]
MAX_W = np.deg2rad(180.0) # maximum speed [m/s]
MIN_W = -np.deg2rad(180.0)  # minimum speed [m/s]
MAX_V_ACCEL = 1.0  # maximum accel [m/ss]
MAX_W_ACCEL = np.deg2rad(90.0)  # maximum accel [m/ss]        
        
def calc_yaw(cx,cy,initial_state,yaw0):
    cyaw = [0]*len(cx)
    # Set stop point
    for i in range(len(cx) - 1):  #0,1,2 ... ,len(cx) - 2
        if i==0:
            cyaw[i] = yaw0
        else:
            dx = cx[i + 1] - cx[i]
            dy = cy[i + 1] - cy[i]
            cyaw[i] = atan2(dy, dx)

        # 防止角度从-pi到pi的突变
        if i==0:
            if initial_state[2]>0 and cyaw[0]<0 and abs(cyaw[0]-initial_state[2])>np.pi: 
                cyaw[i] += 2*np.pi
            if initial_state[2]<0 and cyaw[0]>0 and abs(cyaw[0]-initial_state[2])>np.pi: 
                cyaw[i] -= 2*np.pi
        else:
            if cyaw[i-1]>0 and cyaw[i]<0 and abs(cyaw[i]-cyaw[i-1])>np.pi:
                cyaw[i] += 2*np.pi
            if cyaw[i-1]<0 and cyaw[i]>0 and abs(cyaw[i]-cyaw[i-1])>np.pi:
                cyaw[i] -= 2*np.pi
    cyaw[-1] = cyaw[-2]
    # print('cyaw:', cyaw)
    return cyaw

def get_ReferencePath(cx, cy, cyaw, initial_state):
    # 把cx和cy离散成每两个点的间距为DELTA_D的路径 
    index = 1
    while True:
        if index>=len(cx)-1:
            break
        temp_yaw = atan2(cy[index]-cy[index-1], cx[index]-cx[index-1])
        cx.insert(index,cx[index-1]+DELTA_D*cos(temp_yaw))
        cy.insert(index,cy[index-1]+DELTA_D*sin(temp_yaw))

        if hypot(cx[index+1]-cx[index], cy[index+1]-cy[index]) < DELTA_D:
            cx.pop(index)
            cy.pop(index)

        index += 1
    cyaw = calc_yaw(cx,cy, initial_state, cyaw[0])

    return cx,cy,cyaw

def check_goal(state, goal):
    # check goal
    dx = state[0] - goal[0]
    dy = state[1] - goal[1]
    d = hypot(dx, dy)
    is_arrived = (d <= ARRIVED_DIS)
    is_approaching = (d <= APPROACHING_DIS)
    
    if is_approaching:
        return "approaching"
    if is_arrived:
        return "arrived"

    return "controlling"


def pi_2_pi(angle):
    while(angle > np.pi):
        angle = angle - 2.0 * np.pi

    while(angle < -np.pi):
        angle = angle + 2.0 * np.pi
    return angle

def pubPath(x_list, y_list, topic_name='mpc_path'):
    gui_path = Path()  
    gui_path.header.frame_id = 'map'
    gui_path.header.stamp = rospy.Time.now()
    for i in range(len(x_list)):
        p = PoseStamped()
        p.header.frame_id = 'map'
        p.header.stamp = rospy.Time.now()
        p.pose.position.x = x_list[i]
        p.pose.position.y = y_list[i]
        p.pose.position.z = 0.0
        p.pose.orientation.x = 0.0
        p.pose.orientation.y = 0.0
        p.pose.orientation.z = 0.0
        p.pose.orientation.w = 1.0
        gui_path.poses.append(p)
    pub_path = rospy.Publisher(topic_name, Path, queue_size=1)
    pub_path.publish(gui_path)

def pubReferpath(x_list, y_list, topic_name='reference_path'):
    gui_path = Path()
    gui_path.header.frame_id = 'map'
    gui_path.header.stamp = rospy.Time.now()
    for i in range(len(x_list)):
        p = PoseStamped()
        p.header.frame_id = 'map'
        p.header.stamp = rospy.Time.now()
        p.pose.position.x = x_list[i]
        p.pose.position.y = y_list[i]
        p.pose.position.z = 0.0
        p.pose.orientation.x = 0.0
        p.pose.orientation.y = 0.0
        p.pose.orientation.z = 0.0
        p.pose.orientation.w = 1.0
        gui_path.poses.append(p)
    pub_path = rospy.Publisher(topic_name, Path, queue_size=1)
    pub_path.publish(gui_path)

class MPC_controller:
    # https://blog.csdn.net/weixin_43879302/article/details/105880972
    def __init__(self, current_x, current_y, current_yaw, current_v, current_w):
        self.current_x = current_x
        self.current_y = current_y
        self.current_yaw = current_yaw
        self.current_v = current_v
        self.current_w = current_w

    def defineParams(self):
        self.DT = DT
        self.X_ref = []

    def appendRef(self, ref):
        ref_matrix = np.zeros([3,1])
        for i in range(3):
            ref_matrix[i,0] = ref[i]
        self.X_ref.append(ref_matrix)
    
    def generateBasicMatrixs(self):
        self.getX()
        self.getU()
        self.getA()
        self.getB()
        self.getO()
    
    def getX(self):
        self.X = np.zeros([3,1])
        self.X[0,0] = self.current_x
        self.X[1,0] = self.current_y
        self.X[2,0] = self.current_yaw
        return self.X
    
    def getU(self):
        self.U = np.zeros([2,1])
        self.U[0,0] = self.current_v
        self.U[1,0] = self.current_w
        return self.U

    def getA(self):
        self.A = np.zeros([3,3])
        self.A[0,2] = -self.current_v * sin(self.current_yaw)
        self.A[1,2] = self.current_v * cos(self.current_yaw)
        return self.A
    
    def getB(self):
        self.B = np.zeros([3,2])
        self.B[0,0] = cos(self.current_yaw)
        self.B[1,0] = sin(self.current_yaw)
        self.B[2,1] = 1.0
        return self.B

    def getO(self):
        self.O = -(self.A @ self.X)
        return self.O
    
    def generateOverlineMatrixs(self):
        self.getAOverline()
        self.getBOverline()
        self.getOOverline()
    
    def getAOverline(self):
        temp1 = np.eye(self.A.shape[0]) + self.DT*self.A
        temp2 = temp1 @ temp1
        temp3 = temp1 @ temp1 @ temp1
        self.A_overline = np.r_[temp1, temp2, temp3]
        return self.A_overline
    
    def getBOverline(self):
        temp1 = self.DT*self.B
        temp2 = (np.eye(self.A.shape[0]) + self.DT*self.A) @ (self.DT*self.B)
        temp3 = (np.eye(self.A.shape[0]) + self.DT*self.A) @ (np.eye(self.A.shape[0]) + self.DT*self.A) @ (self.DT*self.B)

        temp11 = np.r_[temp1,temp2,temp3]
        temp12 = np.r_[np.zeros([self.B.shape[0], self.B.shape[1]]), temp1, temp2]
        temp13 = np.r_[np.zeros([self.B.shape[0], self.B.shape[1]]), np.zeros([self.B.shape[0], self.B.shape[1]]), temp1]
        self.B_overline = np.c_[temp11,temp12,temp13]

        return self.B_overline

    def getOOverline(self):
        temp_I = np.eye(self.A.shape[0])
        temp1 = self.DT*self.O - self.X_ref[0]
        temp2 = (temp_I + self.DT*self.A + temp_I) @ (self.DT*self.O) - self.X_ref[1]
        temp3 = ( (temp_I + self.DT*self.A) @ (temp_I + self.DT*self.A) + temp_I +(temp_I + self.DT*self.A) ) @ (self.DT*self.O) - self.X_ref[2]        
        self.O_overline = np.r_[temp1,temp2,temp3]
        return self.O_overline

    def getRealPath(self,u):
        theta1 = self.X[2] + self.DT*u[1]
        x1 = self.X[0] + self.DT*u[0]*cos(self.X[2]*0.5+theta1*0.5)
        y1 = self.X[1] + self.DT*u[0]*sin(self.X[2]*0.5+theta1*0.5)

        theta2 = theta1 + self.DT*u[3]
        x2 = x1 + self.DT*u[2]*cos(theta1*0.5+theta2*0.5)
        y2 = y1 + self.DT*u[2]*sin(theta1*0.5+theta2*0.5)

        theta3 = theta2 + self.DT*u[5]
        x3 = x2 + self.DT*u[4]*cos(theta2*0.5+theta3*0.5)
        y3 = y2 + self.DT*u[4]*sin(theta2*0.5+theta3*0.5)

        x_list = [self.X[0], x1, x2, x3]
        y_list = [self.X[1], y1, y2, y3]
        return x_list, y_list

    def solveProblem(self):
        # pose偏移cost: x1, y1, theta1, x2, y2, theta2, x3, y3, theta3
        self.Q = np.diag([1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])
        # self.Q = np.diag([1.0, 1.0, 0.0, 5.0, 5.0, 0.0, 10.0, 10.0, 0.0])
        # 速度变化cost: v
        # self.R = np.diag([1.0, 1.0, 1.0, 1.0, 1.0, 1.0])
        # 速度偏移cost: v1, w1, v2, w2, v3, w3
        self.M = np.diag([1.0, 0.0, 1.0, 0.0, 1.0, 0.0])
        self.U_G = np.ones([self.U.shape[0]*3, self.U.shape[1]])*GOAL_SPEED

        # 速度边界
        self.bound_for_u_left1 = np.zeros([self.U.shape[0]*3, 1])
        self.bound_for_u_right1 = np.zeros([self.U.shape[0]*3, 1])
        for i in range(3):
            self.bound_for_u_left1[i*self.U.shape[0]] = MIN_V
            self.bound_for_u_left1[i*self.U.shape[0]+1] = MIN_W
            self.bound_for_u_right1[i*self.U.shape[0]] = MAX_V
            self.bound_for_u_right1[i*self.U.shape[0]+1] = MAX_W

        # 加速度边界
        g1 = np.zeros([self.U.shape[0]*3, self.U.shape[0]*3])
        g1[0,2] = 1.0
        g1[1,3] = 1.0
        g1[2,4] = 1.0
        g1[3,5] = 1.0
        g2 = np.eye(self.U.shape[0]*3)
        g2[4,4] = 0
        g2[5,5] = 0
        self.bound_for_u_left2 = np.zeros([self.U.shape[0]*3, 1])
        self.bound_for_u_right2 = np.zeros([self.U.shape[0]*3, 1])
        for i in range(3):
            self.bound_for_u_left2[i*self.U.shape[0]] = -MAX_V_ACCEL*self.DT
            self.bound_for_u_left2[i*self.U.shape[0]+1] = -MAX_W_ACCEL*self.DT
            self.bound_for_u_right2[i*self.U.shape[0]] = MAX_V_ACCEL*self.DT
            self.bound_for_u_right2[i*self.U.shape[0]+1] = MAX_W_ACCEL*self.DT

        # 自变量
        u = cvxpy.Variable((self.U.shape[0]*3, 1))
        # 整合参数，参照.md
        # P = self.M + self.B_overline.T@self.Q@self.B_overline + self.R
        P = self.M + self.B_overline.T@self.Q@self.B_overline
        Q = 2.0*(self.A_overline@self.X + self.O_overline).T@self.Q@self.B_overline-2.0*self.U_G.T@self.M

        # 求解
        prob = cvxpy.Problem(cvxpy.Minimize((1.0/2.0)*cvxpy.quad_form(u, P) + Q @ u),
            [u >= self.bound_for_u_left1,
            u <= self.bound_for_u_right1,
            g1@u-g2@u >= self.bound_for_u_left2,
            g1@u-g2@u <= self.bound_for_u_right2])
        
        prob.solve()
        # Print result.
        
        # print("\nThe optimal value is", prob.value)
        # print("A solution x is")
        # print(u.value)

        # print("A dual solution corresponding to the inequality constraints is")
        # print(prob.constraints[0].dual_value)
        return u.value

def BezierPoint(p0, p1, p2, p3, t):
    bezier_value = p0*(1-t)*(1-t)*(1-t) + 3*p1*t*(1-t)*(1-t) + 3*(1-t)*p2*t*t +p3*t*t*t
    return bezier_value
def get_bezier_path(cx, cy, cyaw, p0, p3, cnum):
    dis = 1.0/3.0*hypot(p0[0]-p3[0], p0[1]-p3[1])
    p1 = [0.0,0.0,0.0]
    p2 = [0.0,0.0,0.0]
    p1[2] = p2[2] = 0.0
    p1[0] = p0[0]+dis*cos(p0[2])
    p1[1] = p0[1]+dis*sin(p0[2])
    p2[0] = p3[0]-dis*cos(p3[2])
    p2[1] = p3[1]-dis*sin(p3[2])
    # print(p0, p1, p2, p3)

    for t in range(100+1):
        x = BezierPoint(p0[0], p1[0], p2[0], p3[0], float(t)/cnum)
        y = BezierPoint(p0[1], p1[1], p2[1], p3[1], float(t)/cnum)
        if (t==cnum):
            cx.append(p3[0])
            cy.append(p3[1])
        else:
            cx.append(x)
            cy.append(y)

    return cx, cy, cyaw

def mpc_tracer(refer_x, refer_y, initial_state, goal_state):
    mode = check_goal(initial_state, goal_state)
    mode = "controlling"
    print('check_goal:', mode)
    if mode == "controlling":
        print("robot_yaw:",initial_state[2])
        p0 = [initial_state[0], initial_state[1],initial_state[2]]
        p3 = [goal_state[0], goal_state[1], 0.0]
        dx = p3[0] - p0[0]
        dy = p3[1] - p0[1]

        yaw_to_end = atan2(dy, dx)
        if p0[2]>0 and yaw_to_end<0 and abs(p0[2]-yaw_to_end)>np.pi: 
                yaw_to_end += 2*np.pi
        if p0[2]<0 and yaw_to_end>0 and abs(p0[2]-yaw_to_end)>np.pi: 
                yaw_to_end -= 2*np.pi
        p0[2] = yaw_to_end
        
        cnum = 100.0
        cx = [p0[0]]
        cy = [p0[1]]
        cyaw = [p0[2]]
        cx, cy, cyaw = get_bezier_path(cx, cy, cyaw, p0, p3, cnum)
        cx, cy, cyaw = get_ReferencePath(cx, cy, cyaw, initial_state)
        pubReferpath(cx, cy, 'reference_path')
        mpc_obj = MPC_controller(initial_state[0], initial_state[1], initial_state[2], initial_state[3], initial_state[4])
        mpc_obj.defineParams()
        mpc_obj.generateBasicMatrixs()
        x_refer = []
        y_refer = []
        for i in range(1,4):
            index = int(i*2*GOAL_SPEED*DT/DELTA_D)

            mpc_obj.appendRef([cx[index],cy[index],cyaw[index]])
            x_refer.append(cx[index])
            y_refer.append(cy[index])

        mpc_obj.generateOverlineMatrixs()
        ans = mpc_obj.solveProblem()

        x_list, y_list = mpc_obj.getRealPath(ans)
        pubPath(x_list,y_list,'/mpc_path')

        cmd_vel = Twist()
        cmd_vel.linear.x = ans[0]
        cmd_vel.angular.z = ans[1]
        return cmd_vel

    elif mode == "approaching":
        dx = goal_state[0]-initial_state[0]
        dy = goal_state[1]-initial_state[1]
        v_desired = hypot(dx, dy) * 2.0
        dtheta = atan2(dy,dx)-initial_state[2]
        if abs(dtheta) > np.pi*110.0/180.0:
            v_desired = -v_desired
            dtheta = pi_2_pi(atan2(dy,dx)+np.pi)-initial_state[2]
        w_desired = dtheta * 3.0

        v_desired = min(v_desired,MAX_V*0.5)
        v_desired = max(v_desired,MIN_V*0.5)
        v_desired = min(v_desired, initial_state[3]+MAX_V_ACCEL*DT)
        v_desired = max(v_desired, initial_state[3]-MAX_V_ACCEL*DT)
        w_desired = min(w_desired, MAX_W*0.5)
        w_desired = max(w_desired, MIN_W*0.5)
        w_desired = min(w_desired, initial_state[4]+MAX_W_ACCEL*DT)
        w_desired = max(w_desired, initial_state[4]-MAX_W_ACCEL*DT)

        cmd_vel = Twist()
        cmd_vel.linear.x = v_desired
        cmd_vel.angular.z = w_desired
        return cmd_vel

        
    elif mode == "arrived":
        cmd_vel = Twist()
        return cmd_vel


class Duel_loop:
    def __init__(self):
        self.res= rospy.Service('local_plan', api_info, self.startCb)
        self.pre_obj = preprocess()
        self.person_msg = Person_msg()

    def startCb(self, req):
        # # test for input
        print ('------------start-----------')
        # receive request and process map
        self.pre_obj.process(req.map, req.robot_pose, req.robot_vel, req.reference_path)
        initial_state = [self.pre_obj.current_pose[0], self.pre_obj.current_pose[1], self.pre_obj.current_pose[2], self.pre_obj.vel[0], self.pre_obj.vel[1]]
        person_state = self.person_msg.person_state_initial ##person_state_initial = [x,y,yaw,vx,xy]
        goal_state = [person_state[0],person_state[1]]
        print('people position:', goal_state)
        goal_state[0] = person_state[0] - 2.0 * sin(pi_2_pi(0.25*np.pi-person_state[2]))
        goal_state[1] = person_state[1] - 2.0 * cos(pi_2_pi(0.25*np.pi-person_state[2]))

        TEP_list.append(hypot(initial_state[0]-goal_state[0], initial_state[1]-goal_state[1]))
        TEP_X.append(len(TEP_list))

        # lfgoal_state[0] = person_state[0] + 1.0 * sin(0.25*np.pi-person_state[2])
        # lfgoal_state[1] = person_state[1] + 1.0 * cos(0.25*np.pi-person_state[2])
        # goal_state = [self.pre_obj.local_goal[0], self.pre_obj.local_goal[1]]
        print('cyaw:', person_state[2])
        robot_xyv[0].append(initial_state[0]) 
        robot_xyv[1].append(initial_state[1])
        robot_xyv[2].append(initial_state[3])
        person_xyv[0].append(person_state[0])
        person_xyv[1].append(person_state[1])
        # person_xyv[0].append(lfgoal_state[0])
        # person_xyv[1].append(lfgoal_state[1])
        person_xyv[2].append(hypot(person_state[3], person_state[4]))
        refer_xy[0].append(goal_state[0])
        refer_xy[1].append(goal_state[1])
        # v_robot.append(initial_state[3])
        # v_person.append(hypot(person_state[3], person_state[4]))

        cmd_vel = mpc_tracer(self.pre_obj.refer_x, self.pre_obj.refer_y, initial_state, goal_state)
        return cmd_vel
        
def initial_for_save():
    robot_xyv = [[],[],[]]
    person_xyv = [[],[],[],[],[]]
    refer_xy = [[],[]]
    lfgoal_state = [[],[]]
    whole_refer_xy = [[],[]]
    distance_person_robot = []
    v_robot = []
    v_person = []

    return robot_xyv, person_xyv, refer_xy, whole_refer_xy, distance_person_robot, v_robot, v_person, lfgoal_state

def draw(robot_xyv, person_xyv, refer_xy):  # robot_xyv[x,y,v], person_xyv[x,y,v,referx,refery]

    fig, ax = plt.subplots()  
    ax.scatter(person_xyv[0][0], person_xyv[1][0], s= 20, c="r")
    ax.plot(robot_xyv[0][20:], robot_xyv[1][20:], "-r", label="robot trajectory")
    ax.plot(person_xyv[0][20:], person_xyv[1][20:], "-k", label="person trajectory")
    ax.plot(refer_xy[0][20:], refer_xy[1][20:], "-b",linewidth = 30 ,alpha = 0.2)
    ax.plot(refer_xy[0][20:], refer_xy[1][20:] ,"-b", label="reference trajectory")

    # whole_refer_xy[0].append(cx[i]+vx*0.1)

    ax.set_xlabel("x[m]")
    ax.set_ylabel("y[m]")
    # legend_element = [Patch(markerfacecolor="r",marker='o',markersize=5 , label="robot trajectory")]

    plt.axis("equal")
    plt.legend()
    plt.savefig('./trajectory1.jpg')
    plt.show()

    return

def draw_TEP(TEP_list, TEP_X):
    fig, ax = plt.subplots()  
    plt.scatter(TEP_X, TEP_list, s = 1, c = 'b')
    TEP = 0.0
    for i in range(50,len(TEP_list)):
        TEP +=  TEP_list[i]
    TEP = TEP/float(len(TEP_list))
    print("TEP:", TEP)
    # plt.plot([0, TEP],[len(TEP_list), TEP], "-r")
    # whole_refer_xy[0].append(cx[i]+vx*0.1)
    ax.set_ylim(0,2)
    ax.set_xlabel("t[m]")
    ax.set_ylabel("TEP[m]")
    # legend_element = [Patch(markerfacecolor="r",marker='o',markersize=5 , label="robot trajectory")]

    plt.axis("equal")
    plt.legend()
    plt.show()

    return

if __name__ == '__main__':
    rospy.init_node('Duel_loop_listener',anonymous=True)
    rospy.Rate(50)  # 1秒50次
    TEP = 0.0
    TEP_list = []
    TEP_X = []
    robot_xyv, person_xyv, refer_xy, whole_refer_xy, distance_person_robot, v_robot, v_person, lfgoal_state = initial_for_save()
    Duel_obj = Duel_loop()
    while not rospy.is_shutdown():
        rospy.spin()
    TEP = TEP/float(len(TEP_list))

    draw_TEP(TEP_list, TEP_X)
    draw(robot_xyv, person_xyv, refer_xy)
