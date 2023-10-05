#!/bin/bash

# Update package list
sudo apt update

# Install Fail2Ban
sudo apt install -y fail2ban

# Create a custom filter for MySQL
echo "[Definition]" | sudo tee /etc/fail2ban/filter.d/mysql.conf
echo "failregex = Access denied for user '\.*'@'<HOST>' (using password: YES)" | sudo tee -a /etc/fail2ban/filter.d/mysql.conf

# Configure Fail2Ban for MySQL
echo "[mysql]" | sudo tee /etc/fail2ban/jail.local
echo "enabled = true" | sudo tee -a /etc/fail2ban/jail.local
echo "port = 3306" | sudo tee -a /etc/fail2ban/jail.local
echo "filter = mysql" | sudo tee -a /etc/fail2ban/jail.local
echo "logpath = /var/log/mysql/error.log" | sudo tee -a /etc/fail2ban/jail.local
echo "maxretry = 2" | sudo tee -a /etc/fail2ban/jail.local
echo "bantime = -1" | sudo tee -a /etc/fail2ban/jail.local

# Restart Fail2Ban
sudo systemctl restart fail2ban

# Additional MySQL Security Configurations

# Disable LOCAL INFILE to prevent reading files from the server
echo "local-infile = 0" | sudo tee -a /etc/mysql/my.cnf

# Enable strict mode for better error handling
echo "sql_mode = STRICT_ALL_TABLES" | sudo tee -a /etc/mysql/my.cnf

# Disable multiple statements in one query
echo "init_connect='SET SESSION sql_mode = CONCAT(@@sql_mode, \",NO_MULTI_STATEMENT\")'" | sudo tee -a /etc/mysql/my.cnf

# Restart MySQL to apply changes
sudo systemctl restart mysql
