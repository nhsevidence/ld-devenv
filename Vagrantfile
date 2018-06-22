# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  # needs vagrant-disksize plugin
  # i.e.: vagrant plugin install vagrant-disksize

  config.disksize.size = "15GB"

  config.vm.hostname = "ld-devenv"

  config.vm.define "ld-devenv" do |ld_devenv|
  end

  #config.vm.synced_folder "C:\\_src\\shared", "/home/vagrant/Shared"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "ld-devenv"
    vb.gui = true
    vb.memory = 4096
    vb.cpus = 2
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