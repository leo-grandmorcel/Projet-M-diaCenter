#!/usr/bin/env bash

if [[ "$(id -u)" != "0" ]] ; then
	echo "This script must be run as root."
	exit 1
fi




#netdate
netdata() {
	apt-get install -y netdata
	ip=$(ip a | grep 'inet ' | grep 'global' | tr -s ' ' | cut -d' ' -f3 | cut -d'/' -f1)
	echo "Create a webhook by following the official documentation - \n"
	echo "https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks"
	read -p "GIVE THE DISCORD WEBHOOK URL" webhook
	sudo sed -i "s#DISCORD_WEBHOOK_URL=\"\"#DISCORD_WEBHOOK_URL=\"$webhook\"#g" /usr/lib/netdata/conf.d/health_alarm_notify.conf
	sudo sed -i "s#DEFAULT_RECIPIENT_DISCORD=\"\"#DEFAULT_RECIPIENT_DISCORD=\"alarms\"#g" /usr/lib/netdata/conf.d/health_alarm_notify.conf
	sudo sed -i "s#SEND_DISCORD=\"NO\"#SEND_DISCORD=\"YES\"#g" /usr/lib/netdata/conf.d/health_alarm_notify.conf
	sudo sed -i "s/127.0.0.1/$ip/g" /etc/netdata/netdata.conf
	systemctl restart netdata
	echo "NetData is installed you can access it to $ip:19999"
}

#nginx
nginx() {
	apt-get install -y nginx snapd
	apt-get remove -y certbot
	snap install core
	snap refresh core
	snap install --classic certbot
	ln -s /snap/bin/certbot /usr/bin/certbot
	touch /etc/nginx/sites-available/"$domain".conf
	rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
	sed -i "s/\!\!\!domainname\!\!\!/$domain/g" nginx.conf.skeleton
	cat nginx.conf.skeleton > /etc/nginx/sites-available/"$domain".conf
	certbot certonly --nginx -m $email -d $domain -q --agree-tos
	ln /etc/nginx/sites-available/$domain.conf /etc/nginx/sites-enabled/
	rm -r /var/www/html
	systemctl restart nginx
}

usage() {
    echo "Usage : Checklist.sh [OPTION]
    Setup your machine 
    -h            Prints help message (this message)
    -m		      Create a monitor with netdata and alert with discord
	-e EMAIL	  Obligatory for NGINX
    -n DOMAIN     Create a reverse proxy with nginx and use the protocol https with let's encrypt"
}

while getopts ":hmn:d:e:" option; do
    case "${option}" in
        h)
            usage
	    	exit 0
            ;;
        m)
            netdata
            ;;
		e)
			email=${OPTARG}
			;;
		n)
			if [[ -n $email ]]; then
				domain=${OPTARG}
            	nginx
			else
				log error "Option ${option} not recognized."
            	usage
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