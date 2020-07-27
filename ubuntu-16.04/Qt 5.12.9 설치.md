# Qt 5.12.9 설치

작성자 : djjin

http://download.qt.io/archive/qt/5.12/5.12.9/

[TOC]

## 1. Install Qt

http://download.qt.io/archive/qt/5.12/5.12.9/

로 들어가  [qt-opensource-linux-x64-5.12.9.run](http://download.qt.io/archive/qt/5.12/5.12.9/qt-opensource-linux-x64-5.12.9.run)  다운

~~~
$ chmod +x qt-opensource-linux-x64-5.12.9.run*
$ ./qt-opensource-linux-x64-5.12.9.run*
~~~

설치가 완료되면

~~~
# qt경로 확인
$ qtchooser -print-env
$ cd /usr/lib/x86_64-linux-gnu/qt-default/qtchooser
$ sudo vi default.conf

기존의 경로 주석처리하고
/home/djjin/Qt5.12.9/5.12.9/gcc_64/bin
/home/djjin/Qt5.12.9/5.12.9/gcc_64
복사
# qt 버전 바뀌었는지 확인
$ qtchooser -print-env
~~~

