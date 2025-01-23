#!/bin/bash

check_users() {
    local users=("dennis" "student" "aubrey" "captain" "snibbles" "brownie" "scooter" "sandy" "perrier" "cindy" "tiger" "yoda")

    for user in "${users[@]}"; do
        id "$user" &>/dev/null
        if [ $? -ne 0 ]; then
            echo "User $user does not exist."
            return 1
        fi
    done

    return 0
}

check_firewall_ports() {
    
    local ports=("22" "80" "443" "3128")

    for port in "${ports[@]}"; do
        nc -zv 127.0.0.1 "$port" &>/dev/null
        if [ $? -ne 0 ]; then
            echo "Port $port is not open."
            return 1
        fi
    done

    return 0
}

check_installed_software() {
    local software=("ufw" "openssh-server" "apache2" "squid")

    for soft in "${software[@]}"; do
        dpkg -l | grep -q "^ii\s*$soft"
        if [ $? -ne 0 ]; then
            echo "Software $soft is not installed."
            return 1
        fi
    done

    return 0
}

check_network_config() {
    local ip_address="192.168.16.21/24"
    local gateway="192.168.16.1"
    local dns_server="192.168.16.1"
    local search_domains=("home.arpa" "localdomain")

    # Check IP address
    ip -br addr | grep -q " $ip_address"
    if [ $? -ne 0 ]; then
        echo "Network configuration for IP address $ip_address not found."
        return 1
    fi

    # Check gateway
    ip route | grep -q "default via $gateway"
    if [ $? -ne 0 ]; then
        echo "Gateway $gateway is not set."
        return 1
    fi

    # Check DNS server
    grep -qE "^\s*nameserver\s+$dns_server$" /etc/resolv.conf
    if [ $? -ne 0 ]; then
        echo "DNS server $dns_server is not set in /etc/resolv.conf."
        return 1
    fi

    # Check search domains
    for domain in "${search_domains[@]}"; do
        grep -qE "^\s*search\s+$domain" /etc/resolv.conf
        if [ $? -ne 0 ]; then
            echo "Search domain $domain is not set in /etc/resolv.conf."
            return 1
        fi
    done

    return 0
}

main() {
    check_users || return 1
    check_firewall_ports || return 1
    check_installed_software || return 1
    check_network_config || return 1

    return 0
}

# Call the main function
main