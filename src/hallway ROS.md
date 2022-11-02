# hallway ROS

> 用于走廊环境中对机器人和行人控制的功能包　
> 添加环境变量：
>
> ```tcl
> source hallwayROS/devel/setup.bash 
> ```



 ## Ａ. 　pedsim_simulation.launch : 启动仿真环境．

> ```assembly
> roslaunch pedsim_simulator pedsim_simulator.launch
> nuo@nuo:~$ roslaunch pedsim_simulator pedsim_simulator.launch robot_mode:=0 person_mode:=0
> 
> ```

1. ```xml
   <arg name="person_mode" default="2">
   ```


    人的运动模式：０使用算法进行控制　１　社会力模型进行控制　２键盘控制

2. ```xml
   <arg name="robot_mode" default="0">
   ```

    机器人的运动模式：０使用算法进行控制　１　社会力模型进行控制　２键盘控制

3. ```xml
   <arg name="scene_file" default="$(find pedsim_simulator)scenes/test.xml"/>
   ```

   场景障碍物的参数设置：
   修改文件：/hallwayROS/src/pedsim_ros/pedsim_simulator/scenes/test.xml

```xml
<obstacle x1="28" y1="8.5" x2="28" y2="11.5" type="line"/>  
<!--Obstacles : start point + end point-->
<obstacle x="13" y="9.3" xHalfLength="1.5" yHalfLength="0.8" type="rectangle"/> 
<!--Obstacles : center point + half width + half height-->
```



## B.　move_base_bridge.launch : 启动算法控制agent运动

> ```assembly
> roslaunch move_base_bridge move_base_bridge.launch     //？？？第一行
> nuo@nuo:~$ roslaunch move_base_bridge move_base_bridge.launch 
> ```

修改使用的算法时，只需解除想要使用的算法部分的注释即可（比如解除11-15行，使用 DWA 算法进行局部规划），同时可以在其中的cpp文件中修改算法本身．
如可修改文件：/hallwayROS/src/baselines/dwa_planner/src/dwa_planner.cpp

```xml
<rosparam file="$(find move_base_bridge)/param/dynamic_global_costmap_params.yaml" command="load" />  
<!--people is Obstacles-->
<rosparam file="$(find move_base_bridge)/param/static_global_costmap_params.yaml" command="load" />
<!--people is not Obstacles-->
```



## C.  接收的部分有用话题信息

```assembly
rostopic echo /persons 　　：：查看/persons话题的信息
```

/map_with_people 和 /map 分别对应了是否将人作为障碍物看待．



## D. rviz使用

https://www.cnblogs.com/tanshengjiang/p/12287028.html



### 实现流程

1. bezier加mpc实现
2. 人的轨迹的一部分作为参考轨迹
3. 使用卡尔曼滤波等方法优化demo

扩展双屏幕https://www.cnblogs.com/arxive/p/13198252.html

##关于编译功能包

* catkin_make  会默认编译上次编译的功能包
* 推荐使用命令 catkin_make -DCATKIN_WHITELIST_PACKAGES=""
  双引号中空着默认编译功能包下所有的文件，写入功能包的名字是只编译指定的功能包

##关于cd和roscd：前者一次只能进入一级文件夹，但后者则可以直接进入到功能包的目录
##关于Python文件修改权限：
先cd到~/script目录下，ll列出所有文件， chmod a+x *.py把所有py文件都设为可执行文件即可rosrun [功能包名] [py文件文件名]。如下：
nuo@nuo:~/hallwayROS/src/baselines/limit_cycle/scripts$ rosrun limit_cycle listener.py 

mpc解决问题和debug的关键：

状态更新：变量之间的关系是否是解耦的，求解偏导矩阵时，比如v和w就是解耦的

求解过程中的状态转移矩阵中的变量不是同一时刻的是不能直接一步更新的，泰勒展开的参考点应该可以近似地看做是机器人当前的状态

1.加入障碍物地图和行人的运动地图，当成障碍物
2.调整跟随的目标点，后半区跟随

复杂环境中的跟随，考虑规划的问题
走廊环境中，参考路径没有问题，考虑MPC控制算法
