# librealsense 설치

작성자 : djjin

Ubuntu 18.04 LTS에서 realsense library 설치하기

https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md#installing-the-packages

[TOC]

## 1. Installing the packages

1. 서버 공개 키 등록

   ~~~
   $ sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
   ~~~

2. 레포지토리 목록 추가

   ~~~
   $ sudo add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u
   ~~~

3. 라이브러리 설치

   librealsens2 udev 규칙, 커널 모듈, 런타임 라이브러리 및 실행 가능한 데모 및 도구를 빌드하고 활성화 해줌

   ~~~
   $ sudo apt-get install librealsense2-dkms
   $ sudo apt-get install librealsense2-utils
   ~~~

4. 개발자 및 디버그 패키지 설치 (Option)

   ~~~
   $ sudo apt-get install librealsense2-dev
   $ sudo apt-get install librealsense2-dbg
   ~~~

5. 리얼센스 뷰어 실행

   ~~~
   $ realsense-viewer
   ~~~



패키지 설명

| Name                     | Content                                                   | Depends on               |
| ------------------------ | --------------------------------------------------------- | ------------------------ |
| librealsense2-udev-rules | Configures RealSense device permissions on kernel level   | -                        |
| librealsense2-dkms       | DKMS package for Depth cameras-specific kernel extensions | librealsense2-udev-rules |
| librealsense2            | RealSense™ SDK runtime (.so) and configuration files      | librealsense2-udev-rules |
| librealsense2-utils      | Demos and tools available as a part of RealSense™ SDK     | librealsense2            |
| librealsense2-dev        | Header files and symbolic link for developers             | librealsense2            |
| librealsense2-dbg        | Debug symbols for developers                              | librealsense2            |





## 2. realsense-ros 설치

ros melodic 버젼

- 워크스페이스 생성

```
$ mkdir -p ~/catkin_ws/src
$ cd ~/catkin_ws/src/
```

- src 디렉토리 안에 realsense-ros.git clone 후 버젼 변경

```
$ git clone https://github.com/IntelRealSense/realsense-ros.git
$ cd realsense-ros/
$ git checkout `git tag | sort -V | grep -P "^\d+\.\d+\.\d+" | tail -1`
$ cd ..
```

- *ddynamic_reconfigure*가 설치되었는지 확인

  ~~~
  확인 안되어 있으면
  $ sudo apt-get install ros-melodic-ddynamic-reconfigure
  ~~~

```
$ catkin_init_workspace
$ cd ..
$ catkin_make clean
$ catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release
$ catkin_make install
$ echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
$ source ~/.bashrc
```

- 카메라 노드 시작

~~~
$ roslaunch realsense2_camera rs_camera.launch
~~~



## 3. SLAM with D435i

D435i Slam 패키지를 사용하기 위해서 4 가지의 노드가 필요합니다.

- realsense2_camera
- imu_filter_madgwick
- rtabmap_ros
- robot_localization



### 1) 설치방법

설치 방법은 아래 내용과 같습니다.

**realsense2_camera:** Follow the installation guide in: https://github.com/intel-ros/realsense.
**imu_filter_madgwick:** `sudo apt-get install ros-melodic-imu-filter-madgwick`
**rtabmap_ros:** `sudo apt-get install ros-melodic-rtabmap-ros`
**robot_localization:** `sudo apt-get install ros-melodic-robot-localization`



### 2) 실행

```
$ roslaunch realsense2_camera opensource_tracking.launch
```



### 3) 맵 저장

- map server  이용

  ~~~
  $ rosrun map_server map_server map:=/rtapmap/proj_map -f my_map_1
  ~~~

- pcl ros 이용

  ~~~
  $ rosrun pcl_ros pointcloud_to_pcd input:=/rtabmap/cloud_map
  ~~~

  포인트 클라우드를 계속 저장하므로 첫 번째 파일 저장 한 후 ctrl + C를 눌러 중지해야 함.

  저장된 pcd 파일을 보려면 pcl viewer 설치

  ~~~
  $ sudo apt-get install pcl-tools
  $ pcl_viewer test.pcd
  ~~~

  