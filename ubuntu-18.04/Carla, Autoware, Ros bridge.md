# Carla, Autoware Install

작성자 : djjin

Ubuntu 18.04, NVIDIA GPU (GTX-1660Ti) 사양에서 설치 진행 

Carla 0.9.6, autoware 1.12 버전을 설치한다.

- 영상 : https://www.youtube.com/watch?v=fL0GJ-Q56js
- CARLA : https://github.com/carla-simulator/carla/releases
- Autoware : https://gitlab.com/autowarefoundation/autoware.ai/autoware/-/wikis/Source-Build
- Carla-autoware : https://gitlab.com/hatem-darweesh-autoware.ai/carla-autoware
- mapping tool : https://github.com/hatem-darweesh/assuremappingtools/tree/ubuntu18.04_build

[TOC]

## 1. Carla Install

1. 아래 주소로 들어가 CARLA 0.9.6 설치

   - https://github.com/carla-simulator/carla/releases

2. 압축을 풀고나서

   ~~~
   $ sudo apt-get install python-pip
   $ pip install --user pygame numpy
   $ ./CarlaUE4.sh
   $ SDL_VIDEODRIVER=offscreen ./CarlaUE4.sh
   $ ./CarlaUE4.sh -opengl
   $ cd PythonAPI/examples
   $ python spawn_npc.py
   $ python manual_control.py
   ~~~

   

   - Simple Default Launch

     -  Cd CARLA_0.9.6 then run $ ./CarlaUE4.sh

   - Launch without window (background launch)

     - $ SDL_VIDEODRIVER=offscreen ./CarlaUE4.sh

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



## lfs 설치

~~~
$ curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
$ sudo apt install git-lfs
~~~

