Automatiser l'installation d'un serveur

Pour le script "preset.sh" Soyez sûr d'avoir le nom que vous voulez donner à votre machine, le nom du user que vous voulez créer.
Pour le script "Setup.sh" Soyez sûr d'avoir le nom de domaine de votre serveur. Si vous utilisez certbot, il vous faudra une adresse mail pour le certificat, et le nom de domaine.

Télécharger le dossier git

ssh-keygen -t rsa -b 4096
ssh-copy-id <user>@<ip>
scp -r <file> <user>@<ip>:<path>
