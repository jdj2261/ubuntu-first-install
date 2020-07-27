# Carla, Autoware, Ros bridge

 설치

작성자 : djjin

OS - Ubuntu 16.04, NVIDIA GPU (GTX-1660Ti) 사양에서 설치 진행 

[TOC]

# Carla 설치

1.  



~~~
$ sudo apt-get install ros-kinetic-jsk-recognition ros-kinetic-jsk-rviz-plugins ros-kinetic-grid-map ros-kinetic-nmea-* ros-kinetic-controller-* ros-kinetic-automotive-* ros-kinetic-pacmod* ros-kinetic-joint-state-controller ros-kinetic-velodyne-pointcloud ros-kinetic-gps-* ros-kinetic-derived-object-msgs ros-kinetic-ackermann-*
~~~

sudo apt-get install ros-melodic-jsk-recognition ros-melodic-jsk-rviz-plugins ros-melodic-grid-map ros-melodic-nmea-* ros-melodic-controller-* ros-melodic-automotive-* ros-melodic-pacmod* ros-melodic-joint-state-controller ros-melodic-velodyne-pointcloud ros-melodic-gps-* ros-melodic-derived-object-msgs ros-melodic-ackermann-*





## lfs 설치

~~~
$ curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
$ sudo apt install git-lfs
~~~

