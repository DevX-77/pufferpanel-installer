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
