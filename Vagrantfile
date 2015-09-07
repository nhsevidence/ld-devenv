# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "box-cutter/ubuntu1404-desktop"
  config.vm.provider "virtualbox" do |v|
    v.name = "ld-devenv"
    v.memory = 4096
    v.cpus = 4
    v.gui = true
  end

  config.vm.hostname = "ld-devenv"
  config.vm.provision "shell", path: "bootstrap_sudo.sh"
  config.vm.provision "shell", path: "bootstrap.sh", privileged: false
  config.vm.provision "file", source: "dotfiles/bashrc", destination: ".bashrc"
end
