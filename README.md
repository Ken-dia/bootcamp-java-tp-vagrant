1. Verifier la configuration
>`vagrant validate`
2. Démarrer le vagrantFile
>`vagrant up`
3. Nous allons se connecter au niveau de la machine devapp01 pour verifier les configutions
>`vagrant ssh devapp01`
- version java
>`java --version`
- version git
>`git --version`
- verifions le status du service tomcat, si il est activé à [serveur tomcat](http://localhost:8082/)
>`sudo systemctl status tomcat`
4. Vérifier l'installation de postgreSql
>`psql --version`
5. ## Configuration de postgresql
- Créer un nouvel utilisateur et une base de données
>sudo -u postgres psql
> CREATE USER kendia WITH PASSWORD 'votre_mot_passe';
>CREATE DATABASE secureapp_db;
>GRANT ALL PRIVILEGES ON DATABASE secureapp_db TO kendia;
>exit;
- Ouvrez le fichier pg_hba.conf pour kendia puisse accéder à la base de données secureapp_db depuis 172.16.238.10(devapp01)
> `sudo nano /etc/postgresql/14/main/pg_hba.conf`
- - Ajoutez une ligne pour autoriser les connexions à distance
>  host    secureapp_d    kendia    172.16.238.10/32    md5
- - Modifiez le fichier postgresql.conf pour permettre les connexions à distance
- - Redémarrez le serveur PostgreSQL
> sudo systemctl restart postgresql
- Configurez le pare-feu
>
