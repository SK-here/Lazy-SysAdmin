#!/bin/bash

# Function to check if a package is installed
is_installed() {
    dpkg -s "$1" &>/dev/null
}

# Function to install a package if it is not installed
install_if_not_installed() {
    if ! is_installed "$1"; then
        sudo apt-get update
        sudo apt-get install -y "$1"
    else
        echo "$1 is already installed."
    fi
}

# Check and install ufw
install_if_not_installed ufw

# Check and configure SSH server
if ! is_installed openssh-server; then
    sudo apt-get update
    sudo apt-get install -y openssh-server
    # Configure SSH to allow key authentication and disable password authentication
    sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo service ssh restart
else
    echo "openssh-server is already installed."
fi

# Check and install Apache2
install_if_not_installed apache2

# Check and install Squid
install_if_not_installed squid

# Configure Apache2 to listen on ports 80 and 443
sudo sed -i 's/Listen 80/Listen 80\nListen 443/' /etc/apache2/ports.conf
sudo service apache2 restart

# Configure Squid to listen on port 3128
sudo sed -i 's/http_port 3128/http_port 3128/' /etc/squid/squid.conf
sudo service squid restart

echo "Installation and configuration completed."