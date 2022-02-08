ON A DU BOULOT

apt install sudo ssh  
systectm start sshd.service

ssh-copy-id <username>@<ip>  
scp <file> <username>@<ip>:<path>

TEST NETDATA BOT DISCORD
cd /usr/libexec/netdata/plugins.d/
./alarm-notify test

Copier le repo git sur votre vps puis lancez le fichier run.sh avec la commande :  
sudo bash run.sh