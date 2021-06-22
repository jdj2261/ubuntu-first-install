#!/bin/bash

# Transform Ubuntu 18.04 or Linux Mint 19 to MacBuntu
# https://www.noobslab.com/2018/08/macbuntu-1804-transformation-pack-ready.html

# If you want to change another version Ubuntu or Linux Mint?
# Search MacBuntu for your version on https://www.noobslab.com/search?q=MacBuntu

# Setup workspace
WORKSPACE=~/Desktop/macbuntu
mkdir $WORKSPACE

# Download MacBuntu OS Wallpapers
mkdir $WORKSPACE/wallpapers/
wget -qO- http://drive.noobslab.com/data/Mac/MacBuntu-Wallpapers.zip | busybox unzip - -d $WORKSPACE/wallpapers/ && mv $WORKSPACE/wallpapers/MacBuntu-Wallpapers $WORKSPACE/wallpapers/macbuntu

# Download default macOS 5K wallpapers
# https://512pixels.net/projects/default-mac-wallpapers-in-5k/
mkdir $WORKSPACE/wallpapers/5k
# wget http://512pixels.net/downloads/macos-wallpapers/10-0_10.1.png -P $WORKSPACE/wallpapers/5k
cat <<EOF | xargs -P 0 wget -P $WORKSPACE/wallpapers/5k
http://512pixels.net/downloads/macos-wallpapers/10-0_10.1.png
http://512pixels.net/downloads/macos-wallpapers/10-2.png
http://512pixels.net/downloads/macos-wallpapers/10-3.png
http://512pixels.net/downloads/macos-wallpapers/10-4.png
http://512pixels.net/downloads/macos-wallpapers/10-5.png
http://512pixels.net/downloads/macos-wallpapers/10-6.png
http://512pixels.net/downloads/macos-wallpapers/10-7.png
http://512pixels.net/downloads/macos-wallpapers/10-8.jpg
http://512pixels.net/downloads/macos-wallpapers/10-9.jpg
http://512pixels.net/downloads/macos-wallpapers/10-10.jpg
http://512pixels.net/downloads/macos-wallpapers/10-11.jpg
http://512pixels.net/downloads/macos-wallpapers/10-12.jpg
http://512pixels.net/downloads/macos-wallpapers/10-13.jpg
https://512pixels.net/downloads/macos-wallpapers/10-14-Day.jpg
https://512pixels.net/downloads/macos-wallpapers/10-14-Night.jpg
http://512pixels.net/downloads/macos-wallpapers/10-15-beta-light.jpg
http://512pixels.net/downloads/macos-wallpapers/10-15-beta-dark.jpg
EOF

# Enter these commands in terminal to get themes, icons and cursors.
# Terminal Commands:
sudo add-apt-repository -y ppa:noobslab/macbuntu
sudo apt-get update
sudo apt-get install -y macbuntu-os-icons-v1804
sudo apt-get install -y macbuntu-os-ithemes-v1804
# After installation choose theme, icons and mac cursor from tweak tool.


# Uninstall themes and icons
# sudo apt-get remove macbuntu-os-icons-v1804 macbuntu-os-ithemes-v1804


# Install Slingscold (Alternative to Launchpad)
# sudo add-apt-repository -y ppa:noobslab/macbuntu
# sudo apt-get update
sudo apt-get install -y slingscold


# Install Albert Spotlight (Alternative to Mac Spotlight)
# sudo add-apt-repository -y ppa:noobslab/macbuntu
# sudo apt-get update
sudo apt-get install -y albert


# Install Plank Dock
sudo apt-get install -y plank

# Install themes for Plank dock
# sudo add-apt-repository -y ppa:noobslab/macbuntu
# sudo apt-get update
sudo apt-get install -y macbuntu-os-plank-theme-v1804


# Uninstall Plank dock themes
# sudo apt-get autoremove plank macbuntu-os-plank-theme-v1804


# Install Tweak Tools to change Themes & Icons
sudo apt-get install -y gnome-tweak-tool


# Install Monochrome icons for Libreoffice
sudo apt-get install -y libreoffice-style-sifr


# Optional
# Install macOS fonts
# After installation, You can change fonts from Unity-Tweak-Tool, Gnome-Tweak-Tool.
wget -O mac-fonts.zip http://drive.noobslab.com/data/Mac/macfonts.zip
sudo unzip mac-fonts.zip -d /usr/share/fonts && rm mac-fonts.zip
sudo fc-cache -f -v
