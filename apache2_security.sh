#!/bin/bash

# Update and Upgrade Debian 12
echo "Updating and Upgrading Debian 12..."
sudo apt update
sudo apt upgrade -y

# Disable Unnecessary Modules
echo "Disabling Unnecessary Modules..."
sudo a2dismod autoindex
sudo a2dismod status
# Add more modules to disable here

# Enable Essential Modules
echo "Enabling Essential Modules..."
sudo a2enmod mpm_prefork
sudo a2enmod dir
sudo a2enmod mime
sudo a2enmod authz_core
sudo a2enmod log_config
# Add more essential modules here

# Enable reqtimeout to Protect against DDoS Attacks
echo "Configuring reqtimeout..."
echo "<IfModule reqtimeout_module>
    RequestReadTimeout header=20-40,MinRate=500 body=20,MinRate=500
</IfModule>" | sudo tee -a /etc/apache2/apache2.conf

# Enable Fail2Ban
echo "Installing and Enabling Fail2Ban..."
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Enable ModSecurity
echo "Installing and Enabling ModSecurity..."
sudo apt install libapache2-mod-security2 -y
sudo a2enmod security2

# Enable Logging Modules
echo "Enabling Logging Modules..."
# Assuming modules are already installed
echo "# Log format
LogFormat \"%h %l %u %t \\\"%r\\\" %>s %b \\\"%{Referer}i\\\" \\\"%{User-agent}i\\\"\" combined
LogFormat \"%h %l %u %t \\\"%r\\\" %>s %b\" common
LogFormat \"%{Referer}i -> %U\" referer
LogFormat \"%{User-agent}i\" agent
# Access log
CustomLog /var/log/apache2/access.log combined" | sudo tee -a /etc/apache2/apache2.conf

# Set Minimal Permissions for Apache2
echo "Setting Minimal Permissions..."
sudo chown -R www-data:www-data /var/www/

# Disable .htaccess and Directory Browsing
echo "Disabling .htaccess and Directory Browsing..."
echo "<Directory /var/www/>
    AllowOverride None
    Require all granted
    Options -Indexes
</Directory>" | sudo tee -a /etc/apache2/apache2.conf

# Restart Apache2
echo "Restarting Apache2..."
sudo systemctl restart apache2

echo "Apache2 Hardening Complete. Please consider setting up SSL manually."
