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

echo -e "${Light_Cyan}-- Install Typora --${NC}"
sleep 1

func_typora_install()
{
    wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
    sudo add-apt-repository 'deb https://typora.io/linux ./'
    sudo apt-get update
    sudo apt-get install -y typora
}
func_typora_install

echo -e "${Light_BLUE}Finished Typora Install${NC}"
sleep 1


echo -e "${Light_Cyan}-- Install VSCODE --${NC}"
sleep 1

func_vscode_install()
{
    sudo apt-get -y install curl
    sudo apt-get -y install git
    sudo sh -c 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg'
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get update
    sudo apt-get install code
}
func_vscode_install

echo -e "${Light_BLUE}Finished VSCODE INSTALL${NC}"
sleep 1
