Vagrant.configure("2") do |config|
  config.vm.define "devapp01" do |webserver|
    webserver.vm.box = "bento/ubuntu-22.04"
    webserver.vm.hostname = "devapp01"
    webserver.vm.network "forwarded_port", guest: 8080, host: 8082
    webserver.vm.network "private_network", ip: "172.16.238.10"
    webserver.vm.synced_folder "shared_folder", "/opt/tomcat/webapps"
      webserver.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "devapp01"
      vb.memory = "1024"
    end
    webserver.vm.provision "shell", path: "scriptwebserver.sh"
  end
  config.vm.define "devapp02" do |database|
    database.vm.box = "bento/ubuntu-22.04"
    database.vm.hostname = "dbapp02"
    database.vm.network "private_network", ip: "172.16.238.11"
    database.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "dbapp02"
      vb.memory = "1024"
    end
    database.vm.provision "shell", path: "scriptdb.sh"
  end

  config.vm.define "backupserver" do |backupserver|
    backupserver.vm.box = "bento/ubuntu-22.04"
    backupserver.vm.hostname = "backupserver"
    backupserver.vm.network "private_network", ip: "172.16.238.12"
    backupserver.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "backupserver"
      vb.memory = "1024"
    end
  end
end
