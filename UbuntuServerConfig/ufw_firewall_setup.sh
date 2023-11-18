#!/bin/bash

# Function to check if a UFW rule exists
ufw_rule_exists() {
    local rule=$1
    ufw status | grep -q "^$rule"
}

# Enable and start UFW if it's not already enabled
if ! ufw status | grep -q "Status: active"; then
    echo "Enabling and starting UFW..."
    sudo ufw --force enable
    echo "UFW enabled and started."
fi

# Allow SSH (port 22)
if ! ufw_rule_exists "22/tcp"; then
    echo "Allowing SSH (port 22)..."
    sudo ufw allow 22/tcp
    echo "SSH allowed."
fi

# Allow HTTP (port 80)
if ! ufw_rule_exists "80/tcp"; then
    echo "Allowing HTTP (port 80)..."
    sudo ufw allow 80/tcp
    echo "HTTP allowed."
fi

# Allow HTTPS (port 443)
if ! ufw_rule_exists "443/tcp"; then
    echo "Allowing HTTPS (port 443)..."
    sudo ufw allow 443/tcp
    echo "HTTPS allowed."
fi

# Allow Web Proxy (port 3128)
if ! ufw_rule_exists "3128/tcp"; then
    echo "Allowing Web Proxy (port 3128)..."
    sudo ufw allow 3128/tcp
    echo "Web Proxy allowed."
fi

# Reload UFW to apply the changes
sudo ufw reload

echo "Firewall enabled and configured with the necessary rules."
