#!/bin/bash
clear
echo 
"#######################################################################                                                                                  
   Project 'pufferpanel-installer'                                                                                                                                      
   Copyright (C) 2024, DevX                                                                                                                                         
   This program is free software: you can redistribute it and/or modify            
   it under the terms of the MIT License.                                                                                                                        
   This program is distributed in the hope that it will be useful,                  
   but WITHOUT ANY WARRANTY; without even the implied warranty of                   
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                    
   MIT License for more details.                                                                                                                                   
   You should have received a copy of the MIT License                               
   along with this program.  If not, see                                            
   https://github.com/DevX-77/pufferpanel-installer/blob/main/LICENSE.                                                                                            
   This script is not associated with the official Pufferpanel Project.             
 ######################################################################"

echo "What would you like to do?:"
echo "[1] Install PufferPanel Using (x86 linux vps)"
echo "[2] Install PufferPanel Using (docker vps)"
echo "[3] Uninstall PufferPanel On (x86 linux vps)"
echo "[4] Install Ngrok"
echo "[5] Uninstall Ngrok"
read option

# Input validation
if ! [[ "$option" =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid input. Please enter a number."
    exit 1
fi
if [ "$option" -eq 1 ]; then
    clear
    echo "Downloading PufferPanel Please Wait."
    curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh?any=true | sudo bash
    sudo apt update
    sudo apt-get install pufferpanel
    clear
    echo "Enter the username for the admin user:"
    read Username
    echo "Enter the password for the admin user:"
    read Password
    echo "Enter the email for the admin user:"
    read Email
    sudo pufferpanel user add --name "$Username" --password "$Password" --email "$Email" --admin
    sudo systemctl enable --now pufferpanel
    clear
    echo "Installed PufferPanel & Started On You're VPS"
fi
elif [ "$option" -eq 2 ]; then
    clear
    mkdir -p /var/lib/pufferpanel
    docker volume create pufferpanel-config
    docker create --name pufferpanel -p 8080:8080 -p 5657:5657 -v pufferpanel-config:/etc/pufferpanel -v /var/lib/pufferpanel:/var/lib/pufferpanel -v /var/run/docker.sock:/var/run/docker.sock --restart=on-failure pufferpanel/pufferpanel:latest
    docker start pufferpanel
    clear
    echo "Enter the username for the admin user:"
    read Username
    echo "Enter the password for the admin user:"
    read Password
    echo "Enter the email for the admin user:"
    read Email
    docker exec -it pufferpanel /pufferpanel/pufferpanel user add --name "$Username" --password "$Password" --email "$Email" --admin
    clear
    echo "Installed PufferPanel & Started On You're VPS"
fi
elif [ "$option" -eq 3 ]; then
    clear
    echo "Are you sure you want to uninstall PuffePanel? (yes/no):"
    read install_choice
    if [ "$install_choice" == "yes" ]; then
        echo "Uninstalling PuffePanel..."
        sudo systemctl stop puffepanel
        sudo systemctl disable puffepanel
        sudo apt remove pufferpanel -y
        sudo rm -rf /var/www/puffepanel
        sudo rm -rf /etc/puffepanel
        sudo rm -rf /var/lib/pufferpanel
        sudo rm -rf /var/log/pufferpanel
        sudo rm -rf /srv/pufferpanel
        sudo userdel puffepanel
        sudo groupdel puffepanel
        sudo apt autoremove -y
        sudo rm /etc/systemd/system/puffepanel.service
        sudo systemctl daemon-reload
        clear
        echo "PuffePanel has been uninstalled successfully."
    else
        echo "Uninstallation canceled."
fi
elif [ "$option" -eq 4 ]; then
