#!/bin/bash
clear
echo "#######################################################################                                                                                  
   Project 'pufferpanel-installer'                                                                                                                                      
   Copyright (C) 2024, DevX                                                                                                                                         
   This program is free software: you can redistribute it and/or modify            
   it under the terms of the MIT License.                                                                                                                        
   This program is distributed in the hope that it will be useful,                  
   but WITHOUT ANY WARRANTY; without even the implied warranty of                   
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                    
   MIT License for more details.                                                                                                                                   
   You should have received a copy of the MIT License                               
   along with this program. If not, see                                            
   https://github.com/DevX-77/pufferpanel-installer/blob/main/LICENSE.                                                                                            
   This script is not associated with the official PufferPanel Project.             
 ######################################################################"

echo "What would you like to do?:"
echo "[1] Install PufferPanel (x86 Linux VPS)"
echo "[2] Install PufferPanel (Docker VPS)"
echo "[3] Uninstall PufferPanel (x86 Linux VPS)"
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
    echo "Downloading PufferPanel. Please wait..."
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
    echo "PufferPanel has been installed and started on your VPS."
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
    echo "PufferPanel has been installed and started on your VPS."
elif [ "$option" -eq 3 ]; then
    clear
    echo "Are you sure you want to uninstall PufferPanel? (yes/no):"
    read install_choice
    if [ "$install_choice" == "yes" ]; then
        echo "Uninstalling PufferPanel..."
        sudo systemctl stop pufferpanel
        sudo systemctl disable pufferpanel
        sudo apt remove pufferpanel -y
        sudo rm -rf /var/www/pufferpanel
        sudo rm -rf /etc/pufferpanel
        sudo rm -rf /var/lib/pufferpanel
        sudo rm -rf /var/log/pufferpanel
        sudo rm -rf /srv/pufferpanel
        sudo userdel pufferpanel
        sudo groupdel pufferpanel
        sudo apt autoremove -y
        sudo rm /etc/systemd/system/pufferpanel.service
        sudo systemctl daemon-reload
        clear
        echo "PufferPanel has been uninstalled successfully."
    else
        echo "Uninstallation canceled."
    fi
elif [ "$option" -eq 4 ]; then
    clear
    echo "Installing Ngrok..."
    wget -O ngrok.tgz https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
    tar -xf ngrok.tgz
    clear
    echo "Enter your Ngrok Auth Token (get it from ngrok.com):"
    read NgrokAuthToken
    ./ngrok config add-authtoken "$NgrokAuthToken"
    clear
    echo "Installation complete. Do you want to automatically start a tunnel? (yes/no)"
    read install_choice
    if [ "$install_choice" == "yes" ]; then
        echo "Setup the Ngrok tunnel manually, eg, ./ngrok http 8080"
        exit 0
    else
        echo "Enter the port you want to tunnel:"
        read port
        clear
        echo "Starting Ngrok tunnel on port $port..."
        ./ngrok http "$port" > /dev/null 2>&1 &
        sleep 5  # Wait for Ngrok to start
        ngrok_url=$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')
        echo "Ngrok started successfully! Access your tunnel at: $ngrok_url"
    fi
else
    echo "Invalid option selected."
    exit 1
fi
elif [ "$option" -eq 5 ]; then
    clear
    echo "Stopping all Ngrok tunnels..."
    pkill ngrok
    if [ -f /usr/local/bin/ngrok ]; then
        echo "Removing Ngrok executable..."
        sudo rm /usr/local/bin/ngrok
    fi
    if [ -f ~/ngrok.tgz ]; then
        echo "Removing ngrok.tgz file..."
        rm ~/ngrok.tgz
    fi
    if [ -d ~/.ngrok2 ]; then
        echo "Removing Ngrok configuration directory..."
        rm -rf ~/.ngrok2
    fi
    echo "Ngrok has been successfully uninstalled."
else
    echo "Invalid option selected."
    exit 1
fi
