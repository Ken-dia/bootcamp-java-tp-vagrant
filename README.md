1. Verifier la configuration
`vagrant valide`
2. Démarrer le vagrantFile
`vagrant up`
3. Nous allons se connecter au niveau de la machine devapp01 pour verifier les configutions
`vagrant ssh devapp01`
- version java
`java --version`
- version git
`git --version`
- verifion si le service tomcat si elle active et accéder à [text](http://localhost:8082/)
`sudo systemctl status tomcat`
