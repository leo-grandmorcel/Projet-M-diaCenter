Automatiser l'installation d'un serveur
=======

Pour lancer votre serveur web vous allez avoir besoin d'au minimum une machine sous Debian(11 de préférence).  
Votre machine devra avoir au moins 4Go de ram et 1 CPU.

> Nous conseillons l'utilisations de machine virtuelles telles que des VPS pour l'installation du serveur.

Ensuite, téléchargez simplement ce dépôt git sur votre machine et lancez les scripts "preset.sh" puis "Setup.sh" avec les commandes suivantes:

```
sudo bash Preset.sh -u utilisateur -n "nomdelamachine"

...

sudo bash Setup.sh -m -n -c -e adressemail -d "nomdedomaine"
```

Vous devez donc avoir un accès root ou administrateur sur votre machine pour que le script s'éxecute correctement.

Pour le script "preset.sh" Soyez sûr d'avoir le nom que vous voulez donner à votre machine, le nom du user que vous voulez créer.
Pour le script "Setup.sh" Soyez sûr d'avoir le nom de domaine de votre serveur. Si vous utilisez certbot, il vous faudra une adresse mail pour le certificat, et le nom de domaine.


Que faire après ?
=======

Une fois la manipulation effectuée vous n'avez plus qu'à importer votre application web sur la machine et la faire tourner puis rendez vous sur votre navigateur et rentrez https://"votrenomdedomaine" pour accéder à votre application.  
> Dans un soucis de sécurité l'outils netdata est installé lors de la configuration, il permet de surveiller l'état de la machine et est accessible sur votre navigateur si vous rentrez http://"votrenomdedomaine":19999

Télécharger le dossier git
=======

ssh-keygen -t rsa -b 4096
ssh-copy-id <user>@<ip>
scp -r <file> <user>@<ip>:<path>
> 5b2d0944453bb9f0870a8a4bc8570831b7e90a77
ssh-keygen -t rsa -b 4096
ssh-copy-id <user>@<ip>
scp -r <file> <user>@<ip>:<path>
=======
https://discord.com/api/webhooks/938775610711494676/dUHKm2RakTmY20zMaN4lGerECtHj5KnGT2rY9kPNsb050WnXXDvZVuYz8Q7q0nJFOSqP

TEST NETDATA BOT DISCORD
cd /usr/libexec/netdata/plugins.d/
./alarm-notify test
> c876ecd38173e197aadc4e79a84919bf1e200b89
