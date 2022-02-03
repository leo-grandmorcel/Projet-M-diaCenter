ON A DU BOULOT

apt install sudo ssh
systectm start sshd.service

ssh-copy-id <username>@<ip>
scp <file> <username>@<ip>:<path>


TEST NETDATA BOT DISCORD
cd /usr/libexec/netdata/plugins.d/
./alarm-notify test