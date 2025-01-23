#!/bin/bash

# Set the hostname to 'autosrv'
echo "autosrv" > /etc/hostname
hostname -F /etc/hostname

# Get the current ethernet network interface
eth_interface=$(ip -o -4 route show to default | awk '{print $5}')

# Check if the ethernet interface is available
if [ -z "$eth_interface" ]; then
    echo "Error: Ethernet interface not found."
    exit 1
fi

# Configure the static network on the interface
cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto $eth_interface
iface $eth_interface inet static
    address 192.168.16.21
    netmask 255.255.255.0
    gateway 192.168.16.1
    dns-nameservers 192.168.16.1
    dns-search home.arpa localdomain
EOF

# Restart networking service to apply the changes
sudo systemctl restart networking

echo "Static network configuration applied to interface $eth_interface."
