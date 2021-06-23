#!/bin/bash

#### Colors ####
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
Light_BLUE='\033[1;34m'
Light_Cyan='\033[1;35m'
BLUE='\033[1;36m'
NC='\033[0m' # No Color
##################

echo -e "${Light_Cyan}-- Install ROS Melodic Version --${NC}"
sleep 1

StartTime=$(date +%s)
func_melodic_install()
{
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
    sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
    sudo apt update
    sudo apt -y install ros-melodic-desktop-full
    echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
    source ~/.bashrc
    sudo apt -y install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
    sudo rosdep init
    rosdep update
}
func_melodic_install

echo -e "${Light_BLUE}Finished ROS melodic install${NC}"
sleep 1

source ~/.bashrc
EndTime=$(date +%s)
echo "It takes $(($EndTime - $StartTime)) seconds to complete this task."

