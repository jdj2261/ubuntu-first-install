# darknet_ros 설치

작성자 : djjin

Ubuntu 16.04 LTS에서 darknet_ros (Yolo)설치하기

https://github.com/leggedrobotics/darknet_ros

[TOC]

## 1. Installing the packages

### Dependencies

This software is built on the Robotic Operating System ([ROS]), which needs to be [installed](http://wiki.ros.org/) first. Additionally, YOLO for ROS depends on following software:

- [OpenCV](http://opencv.org/) (computer vision library),
- [boost](http://www.boost.org/) (c++ library),



1. 최신 버전 복제

   ~~~
   $ cd catkin_workspace/src
   $ git clone --recursive https://github.com/leggedrobotics/darknet_ros.git
   $ cd ../
   ~~~

2. Release mode로 빌드 (오래 걸림)

   ~~~
   $ catkin_make -DCMAKE_BUILD_TYPE=Release
   ~~~
   
3. launch파일 실행

   ~~~
   $ roslaunch darknet_ros darknet_ros.launch
   
   아래와 같이 수정
   <?xml version="1.0" encoding="utf-8"?>
   
   <launch>
     <!-- Console launch prefix -->
     <arg name="launch_prefix" default=""/>
     <arg name="image" default="/camera/color/image_raw" />
   
     <!-- Config and weights folder. -->
     <arg name="yolo_weights_path"          default="$(find darknet_ros)/yolo_network_config/weights"/>
     <arg name="yolo_config_path"           default="$(find darknet_ros)/yolo_network_config/cfg"/>
   
     <!-- ROS and network parameter files -->
     <arg name="ros_param_file"             default="$(find darknet_ros)/config/ros.yaml"/>
     <arg name="network_param_file"         default="$(find darknet_ros)/config/yolov2-tiny.yaml"/>
   
     <!-- Load parameters -->
     <rosparam command="load" ns="darknet_ros" file="$(arg ros_param_file)"/>
     <rosparam command="load" ns="darknet_ros" file="$(arg network_param_file)"/>
   
     <!-- Start darknet and ros wrapper -->
     <node pkg="darknet_ros" type="darknet_ros" name="darknet_ros" output="screen" launch-prefix="$(arg launch_prefix)">
       <param name="weights_path"          value="$(arg yolo_weights_path)" />
       <param name="config_path"           value="$(arg yolo_config_path)" />
       <remap from="camera/rgb/image_raw"  to="$(arg image)" />
     </node>
   
    <!--<node name="republish" type="republish" pkg="image_transport" output="screen" 	args="compressed in:=/front_camera/image_raw raw out:=/camera/image_raw" /> -->
   </launch>
   
   ~~~

   

# Tensorflow Object Detector 설치

https://github.com/osrf/tensorflow_object_detector

설치할 때 에러가 좀 보임

1. camera dependencies 설치 (optional)

   ~~~
   $ sudo apt-get install ros-kinetic-usb-cam ros-kinetic-openni2-launch
   ~~~

2. 파이썬 가상환경에서 텐서플로우 설치 (Only CPU)

   나의 경우 GPU가 있으므로 로컬에서 텐서플로우 설치

   ~~~
   $ sudo apt-get install python-pip
   $ python -m pip install tensorflow==1.14
   $ pip install tensorflow-gpu==1.14.0
   
   - "python setup.py egg_info" error 시
   $ pip install --upgrade setuptools
   
   - pip version upgrade
   $ sudo pip install --upgrade pip
   ~~~
   
3. workspace/src로 이동 후

   ~~~
   git clone https://github.com/Kukanani/vision_msgs.git
   git clone https://github.com/osrf/tensorflow_object_detector.git
   cd ~/catkin_ws && catkin_make
   source ~/catkin_ws/devel/setup.bash
   roslaunch tensorflow_object_detector object_detect.launch
   
   런치파일 아래와 같이 수정
   <launch>
           <node pkg= "tensorflow_object_detector" name="detect_ros" type="detect_ros.py"  output="screen"> 
       <remap from='image' to='/camera/color/image_raw'/>
           </node>
           <!-- rviz -->
     <arg name ="rviz" default="true" />
     <arg name ="rviz_file" default="$(find tensorflow_object_detector)/config/display.rviz"/>
           <node pkg ="rviz" type="rviz" name="rviz" output="screen" args= "-d $(arg rviz_file)" if="$(arg rviz)"/>
     <include file="$(find realsense2_camera)/launch/rs_camera.launch"/>
   </launch>
   
   
   ~~~

   


