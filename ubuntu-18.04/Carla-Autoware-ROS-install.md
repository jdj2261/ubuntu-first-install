# Carla-Autoware Install

작성자 : djjin

Ubuntu 18.04, NVIDIA GPU (GTX-1660Ti) 사양에서 CUDA 10.0 설치 후 진행 

Carla 0.9.6, autoware 1.12, carla-autoware, carla-ros-bridge를 설치한다.

- CARLA : https://carla.readthedocs.io/en/latest/start_quickstart/

- Autoware : https://gitlab.com/autowarefoundation/autoware.ai/autoware/-/wikis/Source-Build

- Carla-autoware : https://github.com/carla-simulator/carla-autoware/tree/fix/rolenames

- Carla-ros-bridge : https://github.com/carla-simulator/ros-bridge/tree/0.9.6

  

[TOC]

## 1. Carla Install

1. 아래 주소로 들어가 CARLA 0.9.6 설치

   - https://github.com/carla-simulator/carla/releases

2. autoware-simulator 디렉토리 생성 후 Carla 압축 풀기

   ~~~
   $ cd ~
   $ mkdir -p autoware-simulator/Carla-0.9.6
   $ cd autoware-simulator/Carla-0.9.6
   $ tar -xzvf ~/Downloads/CARLA_0.9.6.tar.gz
   ~~~

3. Carla 실행

   ~~~
   $ sudo apt-get install python-pip
   $ pip install --user pygame numpy
   $ ./CarlaUE4.sh or $ ./CarlaUE4.sh -opengl
   $ cd PythonAPI/examples
   $ python spawn_npc.py
   $ python manual_control.py
   ~~~

   

   - Simple Default Launch

     -  cd CARLA_0.9.6 then run $ ./CarlaUE4.sh

   - Test if the Simulator is working fine

     - $ python PythonAPI/util/test_connection.py

   - Configuration (Graphics)

     - $ ./CarlaUE4.sh -opengl

   -  Configuration (Simulator)

     - $ python PythonAPI/util/config.py

     - Selecting map, weather, fps, host port, enable/disable

       synchronous mode, ... .

     - $ python PythonAPI/util/config.py -m Town01

     

## 2. Autoware Install

1. git-lfs 설치

   ~~~
   $ curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
   $ sudo apt install git-lfs
   ~~~

2. 필수 패키지 설치

   ~~~
   $ sudo apt update
   $ sudo apt install -y python-catkin-pkg python-rosdep ros-$ROS_DISTRO-catkin
   $ sudo apt install -y python3-pip python3-colcon-common-extensions python3-setuptools python3-vcstool
   $ pip3 install -U setuptools
   ~~~

   ~~~
   $ cd && wget http://bitbucket.org/eigen/eigen/get/3.3.7.tar.gz
   $ mkdir eigen && tar --strip-components=1 -xzvf 3.3.7.tar.gz -C eigen 
   $ cd eigen && mkdir build && cd build && cmake .. && make && sudo make install
   $ cd && rm -rf 3.3.7.tar.gz && rm -rf eigen 
   ~~~

3. autoware 1.12 설치

   10분 소요

   ~~~
   $ cd ~/autoware-simulator
   $ mdkir -p /autoware.1.12/src
   $ cd autoware.1.12
   $ wget -O autoware.ai.repos "https://gitlab.com/autowarefoundation/autoware.ai/autoware/raw/1.12.0/autoware.ai.repos?inline=false"
   $ vcs import src < autoware.ai.repos
   $ rosdep update
   $ rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
   $ AUTOWARE_COMPILE_WITH_CUDA=1 colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release
   ~~~

   

## 3. Carla-Autoware Install

1. carla-autoware 설치

   ~~~
   $ cd ~/autoware-simulator
   $ git clone https://github.com/jdj2261/carla-autoware.git
   $ cd carla-autoware/catkin_ws/src
   $ catkin_init_workspace
   $ cd .. && catkin_make
   ~~~

2. autoware_data 디렉토리에 map 파일 복사하기

   ~~~
   $ cd ~/autoware-simulator/carla-autoware
   $ mkdir -p autoware_data/maps && cd autoware_data/maps
   $ cp -r ~/autoware-simulator/Carla-0.9.6/HDMaps/Town0* .
   ~~~

   

## 4. Carla-Ros-Bridge Install

1. carla-ros-bridge 0.9.6 설치

   ~~~
   #setup folder structure
   $ mkdir -p ~/autoware-simulator/carla-ros-bridge/catkin_ws/src
   $ cd ~/autoware-simulator/carla-ros-bridge
   $ git clone -b 0.9.6 https://github.com/carla-simulator/ros-bridge.git
   $ cd catkin_ws/src
   $ ln -s ../../ros-bridge
   $ cd ..
   
   #install required ros-dependencies
   $ rosdep update
   $ rosdep install --from-paths src --ignore-src -r
   
   #build
   $ catkin_make
   ~~~

   

## 5. bashrc에 추가

~~~
$ vi ~/.bashrc
export CARLA_AUTOWARE_ROOT=/home/djjin/autoware-simulator/carla-autoware/autoware_launch
export CARLA_MAPS_PATH=/home/djjin/autoware-simulator/carla-autoware/autoware_data/maps
export CARLA_ROOT=/home/djjin/autoware-simulator/Carla-0.9.6
export PYTHONPATH=/home/djjin/autoware-simulator/Carla-0.9.6/PythonAPI/carla/dist/carla-0.9.6-py2.7-linux-x86_64.egg:${CARLA_ROOT}/PythonAPI

source /home/djjin/autoware-simulator/autoware.1.12/install/setup.bash --extend
source /home/djjin/autoware-simulator/carla-autoware/catkin_ws/devel/setup.bash --extend
source /home/djjin/autoware-simulator/carla-ros-bridge/catkin_ws/devel/setup.bash --extend
$ source ~/.bashrc
~~~



## 6. Carla-Autoware Excute

1. Carla 실행

   ~~~
   # terminal 1
   $ cd autoware-simulator/Carla-0.9.6
   $ ./CarlaUE4.sh -windowed -ResX=320 -ResY=240
   ~~~

2. Carla-autoware 실행

   ~~~
   # terminal 2
   $ cd autoware-simulator/carla-autoware/autoware_launch
   $ roslaunch devel.launch
   ~~~

3.  rviz

   ~~~
   $ rviz
   ~~~

   

