#!/bin/bash

# Mettre à jour les paquets
sudo apt update
#Installation et configuration de la version 17 openJDK
sudo apt -y install openjdk-17-jdk
#Version de Java
java -version 
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
echo $JAVA_HOME

## Installation de tomcat

sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.24/bin/apache-tomcat-10.1.24.tar.gz
sudo mkdir -p /opt/tomcat
sudo tar xzvf apache-tomcat-10.1.24.tar.gz -C /opt/tomcat --strip-components=1
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
sudo chown -R tomcat: /opt/tomcat
sudo sh -c 'chmod +x /opt/tomcat/bin/*.sh'
sudo cat tomcat.conf > /etc/systemd/system/tomcat.service
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
sudo systemctl restart tomcat
sudo ufw allow 8080

## Installation git
sudo apt -y install git
git --version