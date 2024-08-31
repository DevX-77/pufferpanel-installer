#!/bin/bash
clear
echo 
"######################################################################################
#                                                                                    #
#   Project 'pufferpanel-installer'                                                    #
#                                                                                    #
#   Copyright (C) 2024, DevX                                                          #
#                                                                                    #
#   This program is free software: you can redistribute it and/or modify             #
#   it under the terms of the MIT License.                                           #
#                                                                                    #
#   This program is distributed in the hope that it will be useful,                  #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of                   #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                    #
#   MIT License for more details.                                                    #
#                                                                                    #
#   You should have received a copy of the MIT License                               #
#   along with this program.  If not, see                                            #
#   https://github.com/DevX-77/pufferpanel-installer/blob/main/LICENSE.              #
#                                                                                    #
#   This script is not associated with the official Pufferpanel Project.             #
#                                                                                    #                                                                  
######################################################################################"
echo "What would you like to do?:"
echo "[1] Install PufferPanel On (x86 linux vps)"
echo "[2] Install PufferPanel On (free/non pre-configured vps)"
echo "[3] Install PufferPanel On (docker vps)"
echo "[4] Uninstall PufferPanel On (x86 linux vps)"
echo "[5] Install Ngrok"
echo "[6] Uninstall Ngrok"
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
    echo "Installed PufferPanel & Started On You're VPS 8080 Port"
fi
