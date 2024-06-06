1. ## Verifier la configuration
>`vagrant validate`
2. ## Démarrer le vagrantFile
>`vagrant up`
3. ## Nous allons se connecter au niveau de la machine **devapp01** pour verifier les configutions
>`vagrant ssh devapp01`
- version java
>`java --version`
- version git
>`git --version`
- verifions le status du service tomcat, si il est activé à [serveur tomcat](http://localhost:8082/)
>`sudo systemctl status tomcat`
4. ## Vérifier l'installation de postgreSql
- Se connecter d'abord au serveur **devapp02**
```
vagrant ssh devapp02
pqsl --version
```
5. ## Configuration de postgresql
- Créer un nouvel utilisateur et une base de données
```
sudo -u postgres psql
CREATE USER kendia WITH PASSWORD 'votre_mot_passe';
CREATE DATABASE secureapp_db;
GRANT ALL PRIVILEGES ON DATABASE secureapp_db TO kendia;
exit;
```
- Ouvrez le fichier pg_hba.conf pour kendia puisse accéder à la base de données secureapp_db depuis 172.16.238.10(devapp01)
> `sudo nano /etc/postgresql/14/main/pg_hba.conf`
- - Ajoutez une ligne pour autoriser les connexions à distance
>  host    secureapp_d    kendia    172.16.238.10/32    md5
- - Modifiez le fichier postgresql.conf pour permettre les connexions à distance
> sudo nano /etc/postgresql/14/main/postgresql.conf
- - recherchez la ligne *listen_addresses*. Elle devrait être définie comme suit :
> listen_addresses = '*'
- - Redémarrez le serveur PostgreSQL
> sudo systemctl restart postgresql
- Configurez le pare-feu en tapant la commande suivante
>sudo ufw allow from 172.16.238.10 to any port 5432
- Verifier la connectivité entre les deux serveur en tapant la commande suivante sur la machine *devapp01*
> telnet 172.16.238.11 5432
6. ## Configuration du backup du code source
-  vous devez avoir une paire de clés SSH générée sur l'instance "devapp01" et la clé publique associée doit être autorisée sur "backupserver"
- - Utilisez la commande **ssh-keygen** pour générer une nouvelle paire de clés SSH sur **devapp01**.
> `ssh-keygen`
- - Donner des permissions à notre clé
> `chmod 600 ~/.ssh/id_rsa`
- - Copier la clé publique (id_rsa.pub par défaut) sur **backupserver** en tapant la commande suivante sur **devapp01**. 

>`ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@172.16.238.12`
- Tapez la commande suivante pour ouvrir le crontab en mode édition :
> `crontab -e`
- Si c'est la première fois que vous utilisez crontab, il vous sera peut-être demandé de choisir un éditeur par défaut. Choisissez l'éditeur que vous préférez, par exemple, Nano ou Vim.
- Ajoutez la ligne suivante à la fin du fichier pour définir le cron job :
> `0 * * * * rsync -avz -e "ssh -i ~/.ssh/id_rsa" /opt/tomcat/webapps/code username@172.16.238.12:/backup/code/`

- N'oubliez pas de creer le dossier ** backup/code** sur **backupserver** en tapant la commande suivante

> `mkdir -p /backup/code`