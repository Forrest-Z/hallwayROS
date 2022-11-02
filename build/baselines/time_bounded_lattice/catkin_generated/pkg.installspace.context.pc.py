# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "base_local_planner;costmap_2d;nav_core;nav_msgs;pluginlib;roscpp;tf;tf2".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-ltime_bounded_lattice".split(';') if "-ltime_bounded_lattice" != "" else []
PROJECT_NAME = "time_bounded_lattice"
PROJECT_SPACE_DIR = "/home/nuo/hallwayROS/install"
PROJECT_VERSION = "0.0.0"
