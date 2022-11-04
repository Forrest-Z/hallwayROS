# hallwayROS
working for human-following

//debug log
注意：编译使用的命令：
1. 编译工作空间下的所有功能包：
nuo@nuo:~/hallwayROS$ catkin_make -DCATKIN_WHITELIST_PACKAGES=""
2. 编译某个特定的功能包：
nuo@nuo:~/hallwayROS$ catkin_make -DCATKIN_WHITELIST_PACKAGES="move_base"
然后.py文件直接改了保存就可以有不同的效果，.cpp文件需要编译以后可执行文件才有区别
