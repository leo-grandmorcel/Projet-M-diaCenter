#!/usr/bin/env bash

if [[ "$(id -u)" != "0" ]] ; then
	echo "This script must be run as root."
	exit 1
fi

apt install nginx snapd netdata
sudo apt remove certbot
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo cerbot --nginx



rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default

nano /etc/nginx/sites-available/sites.com.conf
ln /etc/nginx/sites-available/${sites}.conf /etc/nginx/sites-enabled/


apt install wget
wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh --disable-telemetry
