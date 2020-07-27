# NVIDIA-DRIVER, CUDA, CuDnn Install

작성자 : djjin

Ubuntu 18.04, NVIDIA GPU (GTX-1660Ti) 사양에서 설치 진행 

[TOC]

## 1. NVIDIA-DRIVER Install

1. 그래픽 드라이버 설치

   아래의 홈페이지 들어가서 그래픽 사양에 맞는 NVIDIA 버젼을 확인한다.

   https://www.nvidia.co.kr/Download/index.aspx?lang=kr

   나의 경우, nvidia-430을 설치한다.

   ~~~
   $ sudo add-apt-repository ppa:graphics-drivers/ppa
   $ sudo apt-get update
   $ apt-cache search nvidia | grep nvidia-driver-440
   $ sudo apt-get install nvidia-driver-440
   ~~~

2. 설치가 되었는지 확인

   ~~~
   $ reboot
   $ nvidia-smi
   ~~~

   NVIDIA, CUDA version을 확인한다.

3.  기존에 설치된 프로그램과 충돌 발생하면

    ~~~
    $ sudo apt --purge autoremove nvidia*
    ~~~

    

## 2. CUDA Install

1. version에 알맞는 CUDA설치

   나의 경우 CUDA 10.0을 필요로 하니 CUDA 10.0을 설치하려고 함.

   아래의 주소로 들어가서 runfile 설치 (크기 2.3G)

   https://developer.nvidia.com/cuda-10.0-download-archive?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=runfilelocal

2. 다운로드 경로로 들어가 run파일 실행

   ~~~
   $ sudo sh cuda_10.1.105_418.39_linux.run
   ~~~

   입력 시 나오는 라이센스 문구는 Ctrl + c를 입력하여 한번에 넘긴다.

   다음으로 나오는 질문에 답은 다음과 같이 하면 됨.

   

3. 환경변수 설정

   입력하는 CUDA 경로는 설치 시 입력했던 경로와 동일해야 함

   ~~~
   echo -e "\n## CUDA and cuDNN paths"  >> ~/.bashrc
   echo 'export PATH=/usr/local/cuda-10.0/bin:${PATH}' >> ~/.bashrc
   echo 'export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:${LD_LIBRARY_PATH}' >> ~/.bashrc
   source ~/.bashrc
   ~~~

4. CUDA가 설치되었는지 확인 

   ~~~
   $ nvcc --version
   ~~~

   설치된 경로 확인

   ~~~
   $ which nvcc
   ~~~

5. 만약 설치를 잘못 했다면 삭제 후 재설치

   ~~~
   $ sudo apt-get --purge -y remove 'nvidia*'
   ~~~

   

## 3. Cudnn Install

ubuntu 18.04버전, cuda 10.0 설치 했음에 유의

1. CuDNN 다운로드

   아래의 주소로 들어가 버젼에 맞는 cuDNN 다운로드

   https://developer.nvidia.com/rdp/cudnn-archive

   로그인 후 다운받을 수 있음

2. 다운받은 파일의 압축 풀기

   ~~~
   $ tar xzvf cudnn-10.0-linux-x64-v7.6.4.38.tgz
   ~~~

3. 폴더 위치 확인 후 해당폴더에 압축 해제한 파일을 복사하고 권한 변경

   ~~~
   $ which nvcc
   /usr/local/cuda-10.0/bin/nvcc
   
   $ sudo cp cuda/lib64/* /usr/local/cuda-10.0/lib64/
   $ sudo cp cuda/include/* /usr/local/cuda-10.0/include/
   
   $ sudo chmod a+r /usr/local/cuda-10.0/lib64/libcudnn*
   $ sudo chmod a+r /usr/local/cuda-10.0/include/cudnn.h
   ~~~

4. 다음 명령어를 입력하여 비슷한 결과가 나오면 설치가 완료된 것

   ~~~
   $ cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2  
   ~~~

   ~~~
   #define CUDNN_MAJOR 7
   #define CUDNN_MINOR 6
   #define CUDNN_PATCHLEVEL 4
   --
   #define CUDNN_VERSION (CUDNN_MAJOR * 1000 + CUDNN_MINOR * 100 + CUDNN_PATCHLEVEL)
   #include "driver_types.h"
   ~~~

5. 마지막으로 필요한 패키지 설치

   ~~~
   $ sudo apt-get install libcupti-dev
   ~~~

   