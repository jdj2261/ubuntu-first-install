## PIP 명령어

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
