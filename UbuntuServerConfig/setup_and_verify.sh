#!/bin/bash

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to run a script if it exists
run_script() {
  if [ -x "$1" ]; then
    echo "Running $1..."
    "$1"
  else
    echo "Script $1 not found or not executable."
  fi
}

# Individual scripts
check_install_software_script="check_install_software.sh"
ufw_firewall_setup_script="ufw_firewall_setup.sh"
server_network_setup_script="server_network_setup.sh"


# Step 1: Check and install software
run_script "$check_install_software_script"

# Step 2: Ubuntu UFW Firewall Setup 
run_script "$ufw_firewall_setup_script"

# Step 3: Ubuntu server network setup 
run_script "$server_network_setup_script"

# Step 4: Verification and applying changes
echo "Verifying system modifications..."

# For Verification

check_config="check_config.sh"
  
run_script "$check_config"

verification_passed=$?

# If verification fails, re-run the scripts to apply changes
if [ "$verification_passed" -ne 0 ]; then
  echo "Verification failed. Reapplying changes..."

  # Re-run the individual scripts
  run_script "$check_install_software_script"
  run_script "$ufw_firewall_setup_script"
  run_script "$server_network_setup_script"

  echo "Verifying system modifications again..."
  # Perform verification again and set `verification_passed` accordingly
  # ...

  # If verification still fails, display a message
  if [ "$verification_passed" = false ]; then
    echo "Verification still failed after reapplying changes. Manual intervention may be required."
  else
    echo "Verification passed after reapplying changes."
  fi
else
  echo "Verification passed. No further action needed."
fi
