#!/bin/bash

# Mettre à jour les paquets
sudo apt update

# Installer PostgreSQL avec l'option -y pour une installation automatique
sudo apt install -y postgresql postgresql-contrib

# Vérifier l'installation
psql --version

# Démarrer le service PostgreSQL
sudo service postgresql start

# Activer le démarrage automatique au démarrage du système
sudo systemctl enable postgresql

echo "Installation de PostgreSQL terminée."

