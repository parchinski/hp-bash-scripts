#!/bin/bash

# Install Fail2Ban
sudo apt update
sudo apt install -y fail2ban

# Configure Fail2Ban
echo "[sshd]" | sudo tee /etc/fail2ban/jail.local
echo "enabled = true" | sudo tee -a /etc/fail2ban/jail.local
echo "port = ssh" | sudo tee -a /etc/fail2ban/jail.local
echo "maxretry = 2" | sudo tee -a /etc/fail2ban/jail.local
echo "bantime = -1" | sudo tee -a /etc/fail2ban/jail.local

# Restart Fail2Ban
sudo systemctl restart fail2ban
