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
echo "1) Install Basic Packages (not recommend)"
echo "2) PufferPanel"
echo "3) PufferPanel & Ngrok"
echo "4) COMING SOON"
read option

# Input validation
if ! [[ "$option" =~ ^[0-9]+$ ]]; then
    echo "Error: Invalid input. Please enter a number."
    exit 1
fi

if [ "$option" -eq 1 ]; then
    clear
    echo "Downloading... Please Wait"
    apt update && apt upgrade
    apt install git curl wget sudo lsof iputils-ping
    apt install systemctl
    curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py
    chmod -R 777 /bin/systemctl
    clear
    echo "Basic Packages Installed!"
    echo "sudo / curl / wget / git / lsof / ping"
elif [ "$option" -eq 2 ]; then
    clear
    echo "Downloading... Please Wait"
    apt update && apt upgrade 
    curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash
    apt-get install pufferpanel
    clear
    echo "PufferPanel installation completed!"
    echo "Enter PufferPanel Port (8080)"
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
    systemctl enable pufferpanel
    systemctl start pufferpanel
    clear
    echo "PufferPanel Created & Started - PORT: $pufferPanelPort"
elif [ "$option" -eq 3 ]; then
    clear
    echo "Downloading... Please Wait"
    apt update && apt upgrade
    curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash
    apt-get install pufferpanel
    clear
    echo "PufferPanel installation completed!"
    echo "Enter PufferPanel Port (8080)"
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
    systemctl enable pufferpanel
    systemctl start puffepanel
    clear
    echo "PufferPanel Created & Started - PORT: $pufferPanelPort"
    clear
    echo "Installing Ngrok... Please Wait"
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
    tar -xf ngrok-v3-stable-linux-amd64.tgz
    echo "Enter Your Ngrok Auth Token : get it from ngrok.com"
    read NgrokAuthToken
    ./ngrok config add-authtoken "$NgrokAuthToken"

    echo "Do you want to tunnel Ngrok port manually? (yes/no):"
    read install_choice

    if [ "$install_choice" == "yes" ]; then
        echo "Please setup Ngrok tunnel manually."
        exit 0
    else
        echo "Enter the port you want to tunnel:"
        read port
        clear
        echo "Starting Ngrok tunnel on port $port..."
        ./ngrok http "$port" > /dev/null 2>&1 &

        # Wait a moment to allow Ngrok to start
        sleep 5

        ngrok_url=$(curl -s http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels[0].public_url')
        echo "Ngrok started successfully! Access your tunnel at: $ngrok_url"
    fi
else
    echo "Invalid option selected."
    exit 1
fi
