# Install script for directory: /home/nuo/hallwayROS/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/nuo/hallwayROS/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/nuo/hallwayROS/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/nuo/hallwayROS/install" TYPE PROGRAM FILES "/home/nuo/hallwayROS/build/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/nuo/hallwayROS/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/nuo/hallwayROS/install" TYPE PROGRAM FILES "/home/nuo/hallwayROS/build/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/nuo/hallwayROS/install/setup.bash;/home/nuo/hallwayROS/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/nuo/hallwayROS/install" TYPE FILE FILES
    "/home/nuo/hallwayROS/build/catkin_generated/installspace/setup.bash"
    "/home/nuo/hallwayROS/build/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/nuo/hallwayROS/install/setup.sh;/home/nuo/hallwayROS/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/nuo/hallwayROS/install" TYPE FILE FILES
    "/home/nuo/hallwayROS/build/catkin_generated/installspace/setup.sh"
    "/home/nuo/hallwayROS/build/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/nuo/hallwayROS/install/setup.zsh;/home/nuo/hallwayROS/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/nuo/hallwayROS/install" TYPE FILE FILES
    "/home/nuo/hallwayROS/build/catkin_generated/installspace/setup.zsh"
    "/home/nuo/hallwayROS/build/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/nuo/hallwayROS/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/nuo/hallwayROS/install" TYPE FILE FILES "/home/nuo/hallwayROS/build/catkin_generated/installspace/.rosinstall")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/nuo/hallwayROS/build/gtest/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/pedsim_ros/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/move_base_bridge/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/3rdparty/libpedsim/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/2ndparty/spencer_messages/spencer_human_attribute_msgs/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/2ndparty/spencer_messages/spencer_tracking_msgs/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/pedsim_msgs/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/pedsim_srvs/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/pedsim_utils/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/pedsim_visualizer/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/2ndparty/spencer_messages/spencer_social_relation_msgs/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/2ndparty/spencer_messages/spencer_vision_msgs/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_map/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/pedsim_simulator/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/fake_localization/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/pedsim_ros_imp/2ndparty/spencer_tracking_rviz_plugin/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/costmap_2d/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/baselines/api2python/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/baselines/bezier_local_planner/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/baselines/dwa_planner/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/baselines/mpc_tracer/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/baselines/participant_game_lattice/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/move_base/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/baselines/teb_local_planner/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/baselines/time_bounded_lattice/cmake_install.cmake")
  include("/home/nuo/hallwayROS/build/water_description/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/nuo/hallwayROS/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
