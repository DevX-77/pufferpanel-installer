#!/bin/bash
clear
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
echo "
#######################################################################################
#
#                                  ULTIMATE PUFFEPANEL INSTALLER 
#
#                           ALL IN ONE MODIFIED SCRIPT BY DEVBHAI7
#
#
#######################################################################################"
echo "Select an option:"
echo "1) Install Basic Packages (optional)"
echo "2) PufferPanel"
echo "3) PufferPanel & Ngrok"
echo "4) COMING SOON"
read option

if [ $option -eq 1 ]; then
    clear
    echo -e "${RED}Downloading... Please Wait"
     apt update && apt upgrade -y
     apt install git curl wget sudo lsof iputils-ping -y
     curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py
     chmod -R 777 /bin/systemctl
     clear
    echo -e "${GREEN}Basic Packages Installed!" 
    echo -e "${RED}sudo / curl / wget / git / lsof / ping"
elif [ $option -eq 2 ]; then
    clear
    echo -e "${RED}Downloading... Please Wait"
    apt update && apt upgrade -y
    export SUDO_FORCE_REMOVE=yes
    apt remove sudo -y
    apt install curl wget git python3 -y
    curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash
    apt update && apt upgrade -y
    apt install pufferpanel
    clear
    echo -e "${GREEN}PufferPanel installation completed!"
    echo -e "${YELLOW}Enter PufferPanel Port"
    read pufferPanelPort

    sed -i "s/\"host\": \"0.0.0.0:8080\"/\"host\": \"0.0.0.0:$pufferPanelPort\"/g" /etc/pufferpanel/config.json
    echo -e "${YELLOW}Enter the username for the admin user:"
    read adminUsername
    echo -e "${YELLOW}Enter the password for the admin user:"
    read adminPassword
    echo -e "${YELLOW}Enter the email for the admin user:"
    read adminEmail

    pufferpanel user add --name "$adminUsername" --password "$adminPassword" --email "$adminEmail" --admin
    clear
    echo -e "${GREEN}Admin user $adminUsername added successfully!${NC}"
    systemctl restart pufferpanel
    clear
    echo -e "${GREEN}PufferPanel Created & Started - PORT: ${NC}$pufferPanelPort${GREEN}"
elif [ $option -eq 3 ]; then
    clear
    echo -e "${RED}Downloading... Please Wait"
    apt update && apt upgrade -y
    export SUDO_FORCE_REMOVE=yes
    apt remove sudo -y
    apt install curl wget git python3 -y
    curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash
    apt update && apt upgrade -y
    apt install pufferpanel
    clear
    echo -e "${GREEN}PufferPanel installation completed!"
    echo -e "${YELLOW}Enter PufferPanel Port"
    read pufferPanelPort

    sed -i "s/\"host\": \"0.0.0.0:8080\"/\"host\": \"0.0.0.0:$pufferPanelPort\"/g" /etc/pufferpanel/config.json
    echo -e "${YELLOW}Enter the username for the admin user:"
    read adminUsername
    echo -e "${YELLOW}Enter the password for the admin user:"
    read adminPassword
    echo -e "${YELLOW}Enter the email for the admin user:"
    read adminEmail

    pufferpanel user add --name "$adminUsername" --password "$adminPassword" --email "$adminEmail" --admin
    clear
    echo -e "${GREEN}Admin user $adminUsername added successfully!${NC}"
    systemctl restart pufferpanel
    clear
    echo -e "${GREEN}PufferPanel Created & Started - PORT: ${NC}$pufferPanelPort${GREEN}"
    echo -e "${RED}Installing Ngrok... Please Wait"
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
    tar -xf ngrok-v3-stable-linux-amd64.tgz
    echo -e "${YELLOW}Enter Your Ngrok Auth Token:${NC}"
    read NgrokAuthToken
    ./ngrok config add-authtoken $NgrokAuthToken
    echo -e "${YELLOW}Enter the port you want to tunnel:${NC}"
    read port
    echo -e "${GREEN}Starting Ngrok tunnel on port $port...${NC}"
    ./ngrok http $port &
