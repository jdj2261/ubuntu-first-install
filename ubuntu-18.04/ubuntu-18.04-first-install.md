

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
$ sudo apt-get -y install google-chrome-stable
$ sudo rm -rf /etc/apt/sources.list.d/google.list
$ sudo apt-get clean
$ sudo apt-get update
~~~

## 3. 한글입력 설정 (fcitx)

- fcitx-hangul 패키지 설치

~~~
$ sudo apt-get -y install fcitx-hangul
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
  $ sudo apt-get -y install vim
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
$ sudo apt-get -y install curl
$ sudo apt-get -y install git
$ sudo sh -c 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg'
$ sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
$ sudo apt-get update
$ sudo apt-get install code
$ code
~~~

현재 디렉토리에 해당하는 파일을 열어보고 싶으면 code . 을 입력하면 된다.

Theme 변경 --> ctrl + shift + p 누르고 theme 입력 --> color theme 선택 후 monaki 선택

## 9. Time setting

~~~
$ timedatectl set-local-rtc 1
$ echo "UTC=no" | sudo tee /etc/default/rcS
~~~

## 10. HDD 마운트 

~~~
# UUID 확인
$ ls -l /dev/disk/by-uuid
>>> B226FA2B26F9F069
$ sudo vi /etc/fstab
UUID=B226FA2B26F9F069   /DATA   ntfs    defaults,fmask=0133,dmask=0022,uid=1000,gid=1000        0       0
복사 후 재부팅
~~~

## 11. grub 및 로그인 이미지 변경

- reference

  👉 [grub 이미지 변경](https://ming9mon.tistory.com/8)

  👉 [로그인 배경화면 변경 방법](https://brown.ezphp.net/entry/%EC%9A%B0%EB%B6%84%ED%88%AC-1804-%EB%A1%9C%EA%B7%B8%EC%9D%B8-%EB%B0%B0%EA%B2%BD%ED%99%94%EB%A9%B4-%EB%B3%80%EA%B2%BD%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95)

- grub 이미지 변경

  ~~~shell
  $ sudo apt install -y gimp
  ~~~

  👉 gimp 실행 후 열기 -> 설정할 사진 클릭 -> 다른 이름으로 내보내기 -> 파일 유형 선택에서 TarGY 이미지로 내보내기

  👉 변경할 tga 이미지를 /boot/grub로 복사 또는 이동

  ~~~shell
  $ sudo update-grub
  $ reboot
  ~~~

- 로그인 화면 변경

  ~~~
  $ sudo vi /usr/share/gnome-shell/theme/ubuntu.css
  ~~~

  👉 lockDialogGroup 검색

  ~~~
  #lockDialogGroup {  
    background: #2c001e url(resource:///org/gnome/shell/theme/noise-texture.png);  
    background-repeat: repeat; }
  ~~~

  이 부분을 수정하면 된다. 

  ~~~
  #lockDialogGroup {
    background: #2c001e url(file:///usr/share/backgrounds/lock.jpg);
    background-position: 0 0;
    background-repeat: repeat; }
  ~~~

## 12. 듀얼 모니터 터치 스크린 설정

- reference

  👉 [터치스크린 설정](https://networks.guru/2018/11/23/using-dual-monitor-dual-touch-screens-on-ubuntu/)

  ~~~shell
  $ xinput
   CoolTouch System id=11 [slave pointer (2)]
  $ xinput map-to-output 11 HDMI-1-1
  ~~~

  로그인 시 자동 시작

  ~~~shell
  $ echo "xinput map-to-output 11 HDMI-1-1" | sudo tee /usr/local/bin/align_touchinput
  
  $ chmod +x /usr/local/bin/align_touchinput
  
  $ cat << EOF > ~/.config/autostart/align_touchinput.desktop
  [Desktop Entry]
  Categories=System;Input;Touch
  Comment=align touch input
  Exec=/usr/local/bin/align_touchinput
  Name=align_touchinput
  Type=Application
  EOF
  
  $ reboot
  ~~~

