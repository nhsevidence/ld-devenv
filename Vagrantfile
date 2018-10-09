# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"
  config.vm.box_version = "201806.08.0"

  config.vm.hostname = "ld-devenv"

  config.vm.define "ld-devenv" do |ld_devenv|
  end

  #config.vm.synced_folder "C:\\_src\\Shared", "/home/vagrant/Shared"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "ld-devenv"
    vb.gui = true
    vb.memory = 6100
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--vram", "32"]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
    vb.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", "1", "--device", "0", "--type", "dvddrive", "--medium", "emptydrive"]
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook-base.yml"
    ansible.verbose = true
  end

  #config.vm.provision "ansible_local" do |ansible|
  #  ansible.playbook = "playbook-bnf.yml"
  #  ansible.verbose = true
  #end

end