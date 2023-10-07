#!/bin/bash

if [[ $EUID -ne 0 ]]
then
  echo "Woah there, you have to be root/sudo to run this!"
  exit 1
fi

sudo echo ".---------------------------------."           
     echo "l  .---------------------------.  l"         
     echo "l[]l                           l[]l"         
     echo "l  l  Inserting the Floppy ... l  l"          
     echo "l  l                           l  l"          
     echo "l  l  Script by Coleson Hannan l  l"     
     echo "l  l                           l  l"          
     echo "l  l                           l  l"          
     echo "l  l                           l  l"          
     echo "l  l                           l  l"          
     echo "l  l                           l  l"          
     echo "l  l---------------------------l  l"          
     echo "l      __________________ _____   l"          
     echo "l     l   ___            l     l  l"          
     echo "l     l  l   l           l     l  l"          
     echo "l     l  l   l           l     l  l"          
     echo "l     l  l   l           l     l  l"          
     echo "l     l  l___l           l     l  l"          
     echo "l_____l__________________l_____l__l"
sleep 3
#Countdown

sudo echo Initializing update sequence...
sleep 2

echo 3
sleep 1

echo 2
sleep 1

echo 1 
sleep 1


sudo apt-get install auditd -y -qq

#Install and Setup UFW (Uncomplicated Firewall)

echo Initializing Firewall...
sleep 2

sudo apt-get install ufw
sudo apt-get install gufw
clear
sudo ufw status

sleep 2
clear
#May cause scoring to break (When Gufw [graphical uncomplicated firewall] opens check if outgoing data is enabled)
sudo ufw enable

ufw deny 23
ufw deny 2049
ufw deny 515
ufw deny 111

echo Graphical Uncomplicated Firewall is now installed and can be double checked
sleep 3
clear


#Installing BUM (Boot-Up Manager)
echo Initializing BUM...
sleep 

sudo apt-get install bum

sudo bum

echo Now rid of those nasty processes like apache, cups, and nginx
sleep 3
clear

#Identifying open ports on system by installing net-tools
#Netstat allows for the ports to be listed and is installed by net-tools
echo Initializing net-tools and netstat
sudo apt-get install net-tools

echo Close those ports!
sleep 2
clear

netstat -lan > netstat.log
sleep 1
netstat -pan >> netstat.log
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -V -y install --reinstall coreutils
clear
sudo apt-get autoremove -y -qq
sudo apt-get autoclean -y -qq
sudo apt-get clean -y -qq

#Removes the guest account by manipulating the conf.d file. 
#It changes it by changing the guest account boolean value to false.
#Thus, disabling the account and closing a threat.
#Only run if the readme DOES NOT show ANYTHING about a guest account.
#Remember, when in doubt, keep it out!

#sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" > /etc/lightdm/lightdm.conf.d/50-no-guest.conf'

#IF the readme does not say anything about critical services with ftp, ssh or others, remove the hashtag to run
#This disables remote login by disabling boolean values in conf.d file to have false boolean values.

#sudo sh -c 'printf "[SeatDefaults]\ngreeter-show-remote-login=false\n" >/etc/lightdm/lightdm.conf.d/50-no-remote-login.conf'

#Initalizes the program list she

./Script\ Selection.sh








