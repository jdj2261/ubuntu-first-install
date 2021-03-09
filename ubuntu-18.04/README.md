

# 우분투 18.04 첫 설치 시

작성자 : djjin

매번 우분투 설치할 때 마다 구글링하기가 귀찮아서 따로 정리

https://www.peak-system.com/fileadmin/media/linux/index.htm

[TOC]

## 1. Wi-fi 연결

유선랜 연결을 안한 상태로 우분투를 설치하게 되면 와이파이가 안잡히는 경우가 발생한다.

Ubuntu network adpater가 설치되지 않아서 문제가 발생하는 것이다.

~~~
$ sudo lshw -C network
$ sudo tee /etc/modprobe.d/ideapad.conf <<< "blacklist ideapad_laptop"
$ sudo apt update
$ sudo reboot
~~~


## 2. Google Chrome 설치

~~~
$ wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
$ sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
$ sudo apt-get update
$ sudo apt-get install google-chrome-stable
$ sudo rm -rf /etc/apt/sources.list.d/google.list
$ sudo apt-get clean
$ sudo apt-get update
~~~

## 3. 한글입력 설정 (fcitx)

- fcitx-hangul 패키지 설치

~~~
$ sudo apt-get install fcitx-hangul
~~~

- 시스템 설정에 있는 언어지원 누르고 기본적인 설치 완료
- 키보드 입력 방법에 '**fcitx**'를 선택 후 재부팅
- 시스템설정 - 키보드 - 'Shortcuts 탭' - 'Typing' 으로 이동 후 백스페이스를 눌러 전부 'Disabled'
- 우측상단 화면 시계쪽 '키보드그림'을 누른 후 'Configure'을 클릭
- '입력탭'에서 'korean'을 아래에 있는 '-'버튼을 이용하여 지우고 '+'을 눌러 'Hangul' 추가'
- '글로벌탭'으로 이동후 'Trigger입력방법'을 양쪽다 우측 '한영키'로 설정하고 'Extra key입력방법'은 'Disabled' 

## 4. History Time 보이게 하기

history 명령어를 자주 쓰는데 시간까지 보고 싶어서 설정

- vim 설치도 같이 한다.

  ~~~
  $ sudo apt-get install vim
  $ vi ~/.bashrc
  ---
  ## my alias
  alias vbash='vi ~/.bashrc'
  alias sbash='source ~/.bashrc'
  export HISTTIMEFORMAT="%d/%m/%y %T "  
  ---
  추가
  $ source ~/.bashrc
    
  ~~~

## 5. TYPORA설치

md 파일 에디터 typora를 설치한다.

  ~~~
$ wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
$ sudo add-apt-repository 'deb https://typora.io/linux ./'
$ sudo apt-get update
$ sudo apt-get install typora
  ~~~

## 6. Mac Theme

Mac User를 위한 Mac Theme를 설치한다.

https://gist.github.com/YoshiTheChinchilla/900700b232dddb01a1e78f4819fde954

- 배경화면 변경

~~~
$ wget http://drive.noobslab.com/data/Mac-13.10/MBuntu-Wallpapers.zip
$ unzip MBuntu-Wallpapers.zip
~~~

## 7. QT-Creator 설치

https://ros-qtc-plugin.readthedocs.io/en/latest/_source/How-to-Install-Users.html

위 주소로 들어가 우분투 버전에 맞는 파일 다운로드

##  8. VSCODE 설치

~~~
$ sudo apt-get install curl
$ sudo apt-get install git
$ sudo sh -c 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg'
$ sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
$ sudo apt-get update
$ sudo apt-get install code
$ code
~~~

현재 디렉토리에 해당하는 파일을 열어보고 싶으면 code . 을 입력하면 된다.

Theme 변경 --> ctrl + shift + p 누르고 theme 입력 --> color theme 선택 후 monaki 선택

