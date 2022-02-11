#!/usr/bin/env bash

if [[ "$(id -u)" != "0" ]] ; then
	echo "This script must be run as root."
	exit 1
fi


#netdata
netdata() {
	apt-get install -y netdata
	ip=$(ip a | grep 'inet ' | grep 'global' | tr -s ' ' | cut -d' ' -f3 | cut -d'/' -f1)
	echo "Create a webhook by following the official documentation - \n"
	echo "https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks"
	read -p "GIVE THE DISCORD WEBHOOK URL" webhook
	sed -i "s#DISCORD_WEBHOOK_URL=\"\"#DISCORD_WEBHOOK_URL=\"$webhook\"#g" /usr/lib/netdata/conf.d/health_alarm_notify.conf
	sed -i "s#DEFAULT_RECIPIENT_DISCORD=\"\"#DEFAULT_RECIPIENT_DISCORD=\"alarms\"#g" /usr/lib/netdata/conf.d/health_alarm_notify.conf
	sed -i "s#SEND_DISCORD=\"NO\"#SEND_DISCORD=\"YES\"#g" /usr/lib/netdata/conf.d/health_alarm_notify.conf
	sed -i "s/127.0.0.1/$ip/g" /etc/netdata/netdata.conf
	cat cpu.conf.skeleton > /usr/lib/netdata/conf.d/health.d/cpu.conf
	systemctl restart netdata
	systemctl enable netdata
	echo "NetData is installed you can access it to $ip:19999"
}

#nginx
nginx() {
	apt-get install -y nginx
	touch /etc/nginx/sites-available/server.conf
	rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
	cat nginx.conf.skeleton > /etc/nginx/sites-available/server.conf
	ln /etc/nginx/sites-available/server.conf /etc/nginx/sites-enabled/
	rm -r /var/www/html
	systemctl restart nginx
	systemctl enable nginx
}

certbot(){
	apt-get install -y snapd
	apt-get remove -y certbot
	snap install core
	snap refresh core
	snap install --classic certbot
	ln -s /snap/bin/certbot /usr/bin/certbot
	sed -i "s/\!\!\!domainname\!\!\!/$domain/g" cerbot.conf.skeleton
	cat certbot.conf.skeleton > /etc/nginx/sites-available/server.conf
	certbot certonly --nginx -m $email -d $domain -q --agree-tos
	systemctl restart nginx
}

usage() {
    echo "Usage : Checklist.sh [OPTION]
    Setup your machine 
    -h            Prints help message (this message).
    -m		      Create a monitor with netdata and alert with discord.
	-n            Install NGINX Server.
	-c            Configurate NGINX with a reverse proxy and create a https certificate.
	-e EMAIL	  Obligatory NGINX reverse proxy.
    -d DOMAIN     Obligatory for NGINX."
}



while getopts ":hmnce:d:" option; do
    case "${option}" in
        h)
            usage
	    	exit 0
            ;;
		n)
			nginx
			;;
        m)
			netdata
			;;
		e)
			email=${OPTARG}
			;;
		n)
			domain=${OPTARG}
		c)
			if [ -n $email ] && [ -n $domain ]; then
				certbot
			else
				log error "You must define your email and the domain name for the https certificate."
				exit 1
			fi
			;;
		*)
	    	log error "Option ${option} not recognized."
            usage
	    	exit 1
            ;;
    esac
done

while true; do
    read -p "Reboot to save all changes Y/N" yn
    case $yn in
        [Yy]* ) reboot; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done