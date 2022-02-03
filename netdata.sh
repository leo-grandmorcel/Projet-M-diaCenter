apt install wget
wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh --disable-telemetry
echo "Create a webhook by following the official documentation -"
echo "https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks"
read -p "GIVE THE DISCORD WEBHOOK URL" webhook
sudo sed -i "s#DISCORD_WEBHOOK_URL=\"\"#DISCORD_WEBHOOK_URL=\"$webhook\"#g" /etc/netdata/health_alarm_notify.conf
sudo sed -i "s#DEFAULT_RECIPIENT_DISCORD=\"\"#DEFAULT_RECIPIENT_DISCORD=\"alarms\"#g" /etc/netdata/health_alarm_notify.conf
sudo sed -i "s#SEND_DISCORD=\"NO\"#SEND_DISCORD=\"YES\"#g" /etc/netdata/health_alarm_notify.conf
sudo systemctl restart netdata
echo "NetData is installed you can access it to <ip>:19999"