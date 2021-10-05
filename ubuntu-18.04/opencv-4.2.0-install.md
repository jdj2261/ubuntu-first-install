# OPENCV version 4.2 설치

작성자 : djjin

Ubuntu 18.04 LTS에서 OPENCV 설치하기

[reference](https://webnautes.tistory.com/1186)

[TOC]

## 1. OpenCV x.x 버전 제거

1. opencv x.x 버젼이 설치 되어있으면 4.2 버젼이 제대로 동작하지 않으니 제거

   아래의 명령어 입력 후 버전이 설치되어 있지 않으면 다음단계로 넘어가도 됨.

   ~~~
   $ pkg-config --modversion opencv
   ~~~

   버전이 출력되면 다음 명령어로 OpenCV 패키지 삭제 후 진행

   ~~~
   $ sudo apt-get purge libopencv* python-opencv
   $ sudo apt-get autoremove
   ~~~



## 2. 기존 설치된 패키지 업그레이드

기존의 설치된 패키지들을 업그레이드 해주기 위한 작업

1. 기존에 설치된 패키지들의 새로운 버전이 저장소에 있다면 리스트를 업데이트 하기 위해 실행

   ~~~
   $ sudo apt-get update
   ~~~
   
2. 기존에 설치된 패키지의 새로운 버전이 있으면 업그레이드 진행

   ~~~
   $ sudo apt-get upgrade
   ~~~

3. (Optional) Ubuntu 18.04 설치 후 추가적으로 필요한 코덱, 미디어 라이브러리를 설치

   ~~~
   $ sudo apt install ubuntu-restricted-extras
   ~~~

   

## 3. OpenCV 컴파일 전 필요한 패키지 설치

~~~
$ sudo apt -y install build-essential cmake
$ sudo apt -y install pkg-config

# For still images
$ sudo apt -y install libjpeg-dev libtiff5-dev libjasper-dev libpng-dev

# For videos
$ sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev
$ sudo apt -y install libdc1394-22-dev libxvidcore-dev libx264-dev x264
$ sudo apt -y install libxine2-dev libv4l-dev v4l-utils
$ sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

# GUI
$ sudo apt -y install libgtk-3-dev

# Optimization, Python3, etc.
$ sudo apt -y install libatlas-base-dev libeigen3-dev gfortran
$ sudo apt -y install mesa-utils libgl1-mesa-dri libqt4-opengl-dev
$ sudo apt -y install python-numpy python3-dev python3-numpy libtbb2 libtbb-dev
~~~



## 4. OpenCV 설정과  컴파일 및 설치

1. 소스 코드를 저장할 임시 디렉토리 생성하여 이동 후 진행

   ~~~
   $ mkdir opencv
   $ cd opencv
   ~~~

2. OpenCV 4.2 소스코드를 다운로드하여 압축 풀기

   ~~~
   $ wget -O opencv.zip https://github.com/opencv/opencv/archive/4.2.0.zip
   $ unzip opencv.zip
   ~~~

3. opencv_contrib 소스코드를 다운로드하여 압축 풀기(SIFT, SURF 연산을 위해 필요)

   ~~~
   $ wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.2.0.zip
   $ unzip opencv_contrib.zip
   ~~~

4. opencv-4.2.0 디렉토리로 이동하여 build 디렉토리를 생성 후 이동

   컴파일은 build 디렉토리에서 이루어짐

   ~~~
   $ cd opencv-4.2.0/
   $ mkdir build
   $ cd build
   $ cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=OFF -D WITH_IPP=OFF -D WITH_1394=OFF -D BUILD_WITH_DEBUG_INFO=OFF -D BUILD_DOCS=OFF -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D WITH_QT=OFF -D WITH_GTK=ON -D WITH_OPENGL=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.2.0/modules -D WITH_V4L=ON  -D WITH_FFMPEG=ON -D WITH_XINE=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D OPENCV_GENERATE_PKGCONFIG=ON ../
   ~~~

5. 다음과 같은 메세지 보이면 정상 빌드

   ~~~
   -- Configuring done
   -- Generating done
   -- Build files have been written to: /home/webnautes/opencv/opencv-4.2.0/build
   ~~~

   Python 2 또는 Python 3 라이브러리 항목이 보이지 않을 경우

   아래 경로 추가하여 재 빌드

   ~~~
   -D PYTHON2_INCLUDE_DIR=/usr/include/python2.7 \
   -D PYTHON2_NUMPY_INCLUDE_DIRS=/usr/lib/python2.7/dist-packages/numpy/core/include/ \
   -D PYTHON2_PACKAGES_PATH=/usr/lib/python2.7/dist-packages \
   -D PYTHON2_LIBRARY= /usr/lib/x86_64-linux-gnu/libpython2.7.so \
   -D PYTHON3_INCLUDE_DIR=/usr/include/python3.5m \
   -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/lib/python3/dist-packages/numpy/core/include/ \
   -D PYTHON3_PACKAGES_PATH=/usr/lib/python3.5/dist-packages \
   -D PYTHON3_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.5m.so \
   ../
   ~~~

6. 사용 중인 컴퓨어 CPU 코어수 확인

   ~~~
   $ cat /proc/cpuinfo | grep processor | wc -l
   16
   ~~~

7. make 명령을 사용하여 컴파일 시작 (매우 오래걸림...)

   ~~~
   $ make -j16
   ~~~

8. 컴파일 결과물 설치

   ~~~
   $ sudo make install
   $ sudo ldconfig
   ~~~

9. /etc/ld.so.conf.d/ 디렉토리에 **/usr/local/lib**를 포함하는 설정파일이 있는지 확인

   ~~~
   $ cat /etc/ld.so.conf.d/*
   # libc default configuration
   /usr/local/lib
   # Multiarch support
   /usr/local/lib/x86_64-linux-gnu
   /lib/x86_64-linux-gnu
   /usr/lib/x86_64-linux-gnu
   ~~~



## 5. OpenCV 설치 결과 확인

1. OpenCV 버젼 확인

   ~~~
   $ pkg-config --modversion opencv
   4.2.0
   ~~~

2. c++ 예제 코드 실행

   ~~~
   $ cp /usr/local/share/OpenCV/samples/cpp/facedetect.cpp .
   $ g++ -o facedetect facedetect.cpp $(pkg-config --libs --cflags opencv)
   $ ./facedetect --cascade="/usr/local/share/OpenCV/haarcascades/haarcascade_frontalface_alt.xml" --nested-cascade="/usr/local/share/OpenCV/haarcascades/haarcascade_eye_tree_eyeglasses.xml " --scale=1.3
   ~~~

3. Python 예제 코드 실행

   ~~~
   -- python
   $ python /usr/local/share/OpenCV/samples/python/facedetect.py --cascade "/usr/local/share/OpenCV/haarcascades/haarcascade_frontalface_alt.xml" --nested-cascade "/usr/local/share/OpenCV/haarcascades/haarcascade_eye_tree_eyeglasses.xml" /dev/video0
   ~~~

4. Python 해당 라이브러리 못찾고 확인 안될 경우

   ~~~
   import cv2
   Traceback (most recent call last):
     File "<stdin>", line 1, in <module>
   ImportError: /opt/ros/kinetic/lib/python2.7/dist-packages/cv2.so: undefined symbol: PyCObject_Type
   ~~~

   원인? cv2.so 라이브러리를 먼저 찾도록 되어있고, Python3 cv2.so가 이름이 다르게 되어 있어 발생

   1) /opt/ros/kinetic/lib/python2.7/dist-packages/cv2.so 는 다른 이름으로 rename 하고

   2) python3용 cv2.so를 심볼릭 링크

   ~~~
   $ cd /usr/local/lib/python3.5/dist-packages
   $ sudo mv /opt/ros/kinetic/lib/python2.7/dist-packages/cv2.so /opt/ros/kinetic/lib/python2.7/dist-packages/cv2.so.old
   $ ls -al /opt/ros/kinetic/lib/python2.7/dist-packages 
   
   심볼릭 링크 생성
   $ sudo ln -s `pwd`/cv2.cpython-35m-x86_64-linux-gnu.so `pwd`/cv2.so
   
   심볼릭 링크 생성되었는지 확인
   $ ls -al
   cv2.cpython-35m-x86_64-linux-gnu.so
   cv2.so -> /usr/local/lib/python3.5/dist-packages/cv2.cpython-35m-x86_64-linux-gnu.so
   ~~~

5. opencv 소스코드 디렉토리 삭제 (optional)

   ~~~
   $ cd
   $ rm -rf opencv
   ~~~

   
