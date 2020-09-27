# PIP, Virtualenv

python pip와 virtualenv 설명



## PIP 

1. pip 설치

~~~
$ sudo easy_install pip
~~~



2. pip freeze로 패키지 한번에 설치하기

~~~
$ pip freeze > requirements.txt
$ pip install -r requirements.txt
~~~



3. 지금까지 설치된 모든 패키지 삭제

~~~
$ pip uninstall -r requirements.txt -y
~~~



4. 패키지 특정 버전 설치하기

~~~
$ pip install tensorflow==version
~~~



5. 패키지 삭제

~~~
$ pip uninstall tensorflow
~~~



6. python 설치 경로

~~~
$ which python
~~~



7. python setup.py error 시

upgrade를 해주면 됨

~~~
$ pip install --upgrade setuptools
~~~



## Virtualenv

1. virtualenv 설치

~~~
$ pip install virtualenv
~~~



2. virtualenv로 가상환경 생성

~~~
$ virtualenv 가상환경명
~~~



3. 가상환경 활성화

~~~
$ source 가상환경명/bin/activate
~~~

활성화 되어있는지 확인

~~~
$ which 가상환경명
~~~



4. 가상환경 비활성화

~~~
deactivate
~~~

