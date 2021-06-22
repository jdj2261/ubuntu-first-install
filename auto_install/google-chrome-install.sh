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

echo -e "${Light_Cyan}-- Install Google-chrome --${NC}"
sleep 1

func_google_install()
{
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
    sudo apt update
    sudo apt-get -y install google-chrome-stable
    sudo rm -rf /etc/apt/sources.list.d/google.list
    sudo apt-get clean
    sudo apt-get update
}
func_google_install

echo -e "${Light_BLUE}Finished Google-chrome${NC}"
sleep 1
