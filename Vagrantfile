# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
CONFIG_SSH_PUB = File.join(File.dirname(__FILE__), "~/.ssh/id_rsa.pub")
CONFIG_SSH_PRI = File.join(File.dirname(__FILE__), "~/.ssh/id_rsa")
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "box-cutter/ubuntu1404-desktop"
  config.vm.provider "virtualbox" do |v|
    v.name = "ld-devenv"
    v.memory = 4096
    v.cpus = 2
    v.gui = true
  end
  config.vm.hostname = "ld-devenv"
	config.vm.provision "file", source: "dotfiles/bashrc", destination: ".bashrc"
  config.vm.provision "shell", path: "bootstrap_sudo.sh"
  # config.vm.provision "shell", path: "bootstrap.sh", privileged: false
  if !ENV["GIT_SSH_PUBLIC"].nil?
    config.vm.provision "file", source: ENV["GIT_SSH_PUBLIC"], destination: "~/.ssh/id_rsa.pub"
  else
    if File.exists?(CONFIG_SSH_PUB)
      config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    end
  end
  if !ENV["GIT_SSH_PRIVATE"].nil?
    config.vm.provision "file", source: ENV["GIT_SSH_PRIVATE"], destination: "~/.ssh/id_rsa"
  else
    if File.exists?(CONFIG_SSH_PRI)
      config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "~/.ssh/id_rsa"
    end
  end
  if !ENV["VAGRANT_SYNC_SRC"].nil? && !ENV["VAGRANT_SYNC_DEST"].nil?
    config.vm.synced_folder ENV["VAGRANT_SYNC_SRC"], ENV["VAGRANT_SYNC_DEST"]
  end
end
