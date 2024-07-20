# Notice: its uncompleted due to im busy 
# PufferPanel and Ngrok Auto-Installer for Linux x86 VPS

## Overview

This script automates the installation of [PufferPanel](https://pufferpanel.com/) and [Ngrok](https://ngrok.com/) on your Linux x86 VPS, simplifying the process and saving you time. With this installer, you can easily set up and manage your game servers using PufferPanel, and securely expose your services to the internet with Ngrok.

## Features

- **Automated Installation**: Quickly install PufferPanel and Ngrok with a single command.
- **Seamless Integration**: Designed to work perfectly on Linux x86 VPS environments.
- **Time-Saving**: Eliminate the need for manual configuration and setup.

## Prerequisites

Ensure your VPS meets the following requirements:

- Linux x86 operating system
- Active internet connection
- `sudo` privileges
- `curl` installed (if not, install it using `apt install curl`)

## Installation

You can install PufferPanel and Ngrok using any of the following methods:

1. Using `bash`:
    ```sh
    bash pufferpanel.sh
    ```

2. Making the script executable and running it:
    ```sh
    chmod +x pufferpanel.sh
    ./pufferpanel.sh
    ```

3. Running the script directly from the URL:
    ```sh
   bash <(curl -s https://raw.githubusercontent.com/Devbhai7/pufferpanel-installer/main/pufferpanel.sh)
    ```

### Note:
If `curl` is not installed on your system, install it using the following command:
```sh
apt install curl
```

This script will take care of downloading, installing, and configuring both PufferPanel and Ngrok for your Linux x86 VPS.

## Usage

After installation, you can access PufferPanel through your web browser and use Ngrok to expose your local services.
- Use 1 Option to install basic packages not recommend
- Use 2 Option to install PuffePanel
- Use 3 Option to install Puffepanel+ Ngrok

## Contributing

Contributions are welcome! If you have any suggestions, bug reports, or improvements, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/Devbhai7/pufferpanel-installer/blob/main/LICENSE) file for details.

---

Feel free to adjust this further if needed!
