#!/bin/bash
clear
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
    echo "Downloading... Please Wait"
    apt update && apt upgrade -y
    apt install git curl wget sudo lsof iputils-ping -y
    apt install systemctl
    curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py
    chmod +x /bin/systemctl
    clear
    echo "Basic Packages Installed!" 
    echo "sudo / curl / wget / git / lsof / ping"
elif [ $option -eq 2 ]; then
    clear
    echo "Downloading... Please Wait"
    apt update && apt upgrade -y
    apt install curl wget git python3 -y
    curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash
    apt update && apt install pufferpanel -y
    clear
    echo "PufferPanel installation completed!"
    echo "Enter PufferPanel Port"
    read pufferPanelPort

    sed -i "s/\"host\": \"0.0.0.0:8080\"/\"host\": \"0.0.0.0:$pufferPanelPort\"/g" /etc/pufferpanel/config.json
    echo "Enter the username for the admin user:"
    read adminUsername
    echo "Enter the password for the admin user:"
    read adminPassword
    echo "Enter the email for the admin user:"
    read adminEmail

    pufferpanel user add --name "$adminUsername" --password "$adminPassword" --email "$adminEmail" --admin
    clear
    echo "Admin user $adminUsername added successfully!"
    systemctl restart pufferpanel
    clear
    echo "PufferPanel Created & Started - PORT: $pufferPanelPort"
elif [ $option -eq 3 ]; then
    clear
    echo "Downloading... Please Wait"
    apt update && apt upgrade -y
    apt install curl wget git python3 -y
    curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash
    apt update && apt install pufferpanel -y
    clear
    echo "PufferPanel installation completed!"
    echo "Enter PufferPanel Port"
    read pufferPanelPort

    sed -i "s/\"host\": \"0.0.0.0:8080\"/\"host\": \"0.0.0.0:$pufferPanelPort\"/g" /etc/pufferpanel/config.json
    echo "Enter the username for the admin user:"
    read adminUsername
    echo "Enter the password for the admin user:"
    read adminPassword
    echo "Enter the email for the admin user:"
    read adminEmail

    pufferpanel user add --name "$adminUsername" --password "$adminPassword" --email "$adminEmail" --admin
    clear
    echo "Admin user $adminUsername added successfully!"
    systemctl restart pufferpanel
    clear
    echo "PufferPanel Created & Started - PORT: $pufferPanelPort"
    clear
    echo "Installing Ngrok... Please Wait"
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
    tar -xf ngrok-v3-stable-linux-amd64.tgz
    echo "Enter Your Ngrok Auth Token (get it from ngrok.com)"
    read NgrokAuthToken
    ./ngrok config add-authtoken $NgrokAuthToken
    clear
    echo "now you have to do tunneling mannuly"
    echo "type → ./ngrok http (port) ex ./ngrok http 8080
