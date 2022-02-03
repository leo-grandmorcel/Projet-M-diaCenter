#!/usr/bin/env bash

usage() {
    echo "Usage : Checklist.sh [OPTION]
    Setup your machine 
    -h            Prints help message (this message)
    -u name       Create a new user and his directory.
    -n hostname   Change the name of your machine."
}

user(){
    sudo adduser $newuser
    echo "User $newuser add."
}

pinger(){
    ping -q -c 4 1.1.1.1 &> /dev/null
    if [ $# != 0 ]
    then
        echo "No internet connexion."
    fi
    ping -q -c 4 google.com &> /dev/null
    if [ $# != 0 ]
    then
        echo "No resolution name in ping google.com"
    fi
}

namer(){
    sudo hostname $newname
    lastname=$(cat /etc/hostname)
    sudo sed -i "s/$lastname/$newname/g" /etc/hostname
}

if [[ "$(id -u)" != "0" ]] ; then
	echo "This script must be run as root."
	exit 1
fi

echo "Lancement de l'installation"

while getopts ":hi:u:n:" option; do
    case "${option}" in
        h)
            usage
	    exit 0
            ;;
        i)
            newip=${OPTARG}
            iper
            ;;
        u)
            newuser=${OPTARG}
            user
            ;;
        n)
            newname=${OPTARG}
            namer
            ;;
        *)
	    log error "Option ${option} not recognized."
            usage
	    exit 1
            ;;
    esac
done

pinger
sudo apt update

while true; do
    read -p "Reboot to save all changes Y/N" yn
    case $yn in
        [Yy]* ) sudo reboot; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done