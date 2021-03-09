# PEAK CAN USB 설치

작성자 : djjin

Ubuntu 16.04 LTS에서 peak can usb driver 설치하기

https://www.peak-system.com/fileadmin/media/linux/index.htm

[TOC]

## 1. Installing PCAN Driver Package

1. 파일 다운받은 뒤 압출 풀기

   gcc-multilib package 설치

   ```
    $ sudo apt-get update -y
    $ sudo apt-get install -y gcc-multilib
   ```

2. 패키지 설치 후

   압축해제된 파일 폴더로 이동

   ~~~
   $ sudo apt-get install libelf-dev
   $ sudo apt-get install libpopt-dev
   
   $ cd peak-linux-driver-8.10.1
   $ make
   ~~~

3. 빌드 후 인스톨

   ~~~
   $ make -C lib 
   $ make -C test 
   $ sudo make install 
   ~~~

4. 설치가 제대로 되었는지 확인

   ~~~
   $ sudo modprobe pcan
   $ pcaninfo
   ~~~

   

## 2. PCAN-View 설치

~~~
$ wget -q http://www.peak-system.com/debian/dists/`lsb_release -cs`/peak-system.list -O- | sudo tee /etc/apt/sources.list.d/peak-system.list

$ wget -q http://www.peak-system.com/debian/dists/wheezy/peak-system.list -O- | sudo tee /etc/apt/sources.list.d/peak-system.list

$ wget -q http://www.peak-system.com/debian/peak-system-public-key.asc -O- | sudo apt-key add -

$ sudo apt-get update
$ sudo apt-get install pcanview-ncurses
$ pcanview
~~~



