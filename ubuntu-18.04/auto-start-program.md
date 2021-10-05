# UBUNTU 자동시작 셋팅

바탕화면에 실행 아이콘을 만들고 부팅 시 

자동으로 그 파일을 실행하는 방법

예시 : 10초 동안 1초에 한번 씩 Test라는 문자열을 출력하는 프로그램

## 1. 스크립트 작성하기

1. python script 만들기

~~~
$ mkdir -p examples && cd examples
$ vi pthon_script.py
~~~

아래의 내용 복사 후 저장

> #! /usr/bin/python
> import time
>
> i=0
> while(i < 10) :
>     i += 1
>     print("Test")
>     time.sleep(1)
>
> print("Finished ..")

~~~
$ chomd +x pthon_script.py
실행되는지 확인
$ ./pthon_script.py
~~~



2. bash script 만들기

~~~
$ vi bash_script
~~~

아래의 내용 복사 후 저장

> #! /bin/bash -e
> /opt/examples/python_script

~~~
$ chmod +x bash_script
실행되는지 확인
$ ./bash_script
~~~



3. 폴더 경로를 /opt 디렉토리 안으로 링크걸기

   > /opt 디렉토리에 옮기는 이유? 
   >
   > 응용프로그램(Application)이 /opt 디렉토리 안에 설치됨

~~~
$ sudo ln -s ~/examples /opt
실행되는지 확인
$ /opt/examples/bash_script
~~~



## 2. 바탕화면에 아이콘 만들기

바탕화면에 아이콘을 만드는 방법은 두가지가 있다.

gnome 편집기를 이용하느냐 안하느냐

### 1) gnome 편집기 이용

1. gnome-panel 설치

   ~~~
   $ sudo apt-get install gnome-panel
   ~~~

2. gnome-desktop-item-edit 명령어 이용

   ~~~
   $ gnome-desktop-item-edit ~/Desktop --create-new
   ~~~

3. 이름, 명령어 ,설명 입력 후 OK 버튼 누르기

   이름 : 바탕화면에 보여지는 이름

   명령어 : gnome-terminal -- /opt/examples/bash_script

   설명 : 블라블라

   > 명령어에 " gnome-terminal -- " 후 실행 명령어를 적으면 터미널이 띄워진 상태에서 명령어가 실행된다. 

4. 바탕화면에 만들어진 아이콘을 눌러 실행됨을 확인한다.

### 2) 수기 작성

~~~
$ cd ~/Desktop
$ vi example.desktop
~~~

아래의 내용 복사 후 저장

>i#!/usr/bin/env xdg-open
>[Desktop Entry]
>Version=1.0
>Type=Application
>Icon[en_US]=gnome-panel-launcher
>Terminal=false
>Name[en_US]=TEST
>Exec=gnome-terminal -- /opt/examples/bash_script
>Name=TEST
>Icon=gnome-panel-launcher

~~~
$ chmod +x example.desktop
아이콘 버튼 눌러 실행됨을 확인
~~~



### 3. 자동 시작프로그램 등록

시작 프로그램 검색하여 실행

~~~
이름 : 바탕화면에 보여지는 이름
명령어 : gnome-terminal -- /opt/examples/bash_script
설명 : 블라블라
~~~

입력 후 저장

재부팅 후 자동으로 터미널이 띄워지며 실행되는지 확인한다.