#!/bin/bash

# Array of user accounts
users=("dennis" "student" "aubrey" "captain" "snibbles" "brownie" "scooter" "sandy" "perrier" "cindy" "tiger" "yoda")

# Function to create a user account and set up SSH keys
create_user_with_ssh_keys() {
    local username=$1
    local ssh_key_rsa="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3aasE7xXOc3n40XIU+9PAs6ccF4T7UZI0nlgB7Us9Wn6oQ2DMYb8PRzJyQqnUTc+dU1bVXwRt8n55W9rrz9Fg5GVztEPANt3yv7cJL7wZUHdVTpZxPBBmLZ26JiNbiPffNMkHN63PLwELPK6osFVR8/9mihMQYZ8S8HjA8rsgN5l2oJUw54t5ljmlkLdb7M6ZZb2u6YfoGzRtFAKnWuAY/Y0M6fVskcT4UAMMzzrqL99PxXJgwueI8UJWq6apB6qfo1uU2JFbG3A8jqTV0vtOWMnNpgNRag1fXvSEjsli6kGLeLFN6GRaGo7tMlgXg5x9MsbWc0h9MnbLrz user_rsa_key"
    local ssh_key_ed25519="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4rT3vTt99Ox5knd4HmgTrKBT8SKzhK4rhGkEVGlCI user_ed25519_key"

    echo "Creating user account: $username"
    sudo useradd -m -s /bin/bash "$username"
    sudo mkdir -p "/home/$username/.ssh"
    sudo chown -R "$username:$username" "/home/$username/.ssh"
    echo "$ssh_key_rsa" | sudo tee -a "/home/$username/.ssh/authorized_keys"
    echo "$ssh_key_ed25519" | sudo tee -a "/home/$username/.ssh/authorized_keys"
    sudo chown "$username:$username" "/home/$username/.ssh/authorized_keys"
}

# Create each user account with SSH keys
for user in "${users[@]}"; do
    create_user_with_ssh_keys "$user"
done

# Grant sudo access to the user "dennis"
sudo usermod -aG sudo dennis

echo "User accounts created with SSH keys and sudo access (for dennis)."
