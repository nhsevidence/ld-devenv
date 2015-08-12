# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provider "virtualbox" do |v|
    v.name = "ld-devenv"
    v.memory = 1024
    v.cpus = 2
    v.gui = true
  end

  config.vm.hostname = "ld-devenv"
  config.vm.provision "shell", path: "bootstrap.sh"
end
