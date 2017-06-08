#!/usr/bin/env bash

function install_docker_compose(){
  curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
}

function install_sublime(){
  sudo add-apt-repository ppa:webupd8team/sublime-text-3
  sudo apt-get update
  sudo apt-get install sublime-text-installer
}

function install_docker(){
  docker --version
  if [ $? -ne 0 ]; then
    wget -qO- https://get.docker.com/ | sh
    usermod -aG docker vagrant
  fi
  chown -R vagrant /usr/local/bin/docker
}

function install_rancher_server(){
   RANCHER_SERVER_VERSION=v0.56.1
   sudo docker run -d --restart=always -p 8080:8080 rancher/server:$RANCHER_SERVER_VERSION
}

function main(){
  install_docker
  install_rancher_server
}

function install_docker_machine(){
  curl -L https://github.com/docker/machine/releases/download/v0.4.0/docker-machine_linux-amd64 > /usr/local/bin/docker-machine
  chmod +x /usr/local/bin/docker-machine
}

function install_rancher_compose(){
    RANCHER_COMPOSE_VERSION=v0.7.1

    curl -L https://github.com/rancher/rancher-compose/releases/download/$RANCHER_COMPOSE_VERSION/rancher-compose-linux-amd64-$RANCHER_COMPOSE_VERSION.tar.gz > rancher-compose.tar.gz
    tar -xf rancher-compose.tar.gz
    cd rancher-compose-$RANCHER_COMPOSE_VERSION
    rm -f /usr/local/bin/rancher-compose
    ln rancher-compose /usr/local/bin/rancher-compose
    rm -f rancher-compose*
}

function install_emacs24-5(){
  emacs --version
  if [ $? -ne 0 ]; then
    apt-get install -yy build-essential libgtk2.0-dev libgif-dev libjpeg62-dev libpng12-dev libxpm-dev libncurses-dev
    apt-get build-dep emacs25
    wget http://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.gz
    tar -xzvf emacs-24.5.tar.gz
    rm emacs-24.5.tar.gz
    cd emacs-24.5
    ./configure --prefix=/opt/emacs --with-tiff=no
    make && make install
    cd ..
    ln -s /opt/emacs/bin/emacs-24.5 /usr/local/bin/emacs
  fi
}

function install_spacemacs(){
  git clone --recursive https://github.com/syl20bnr/spacemacs /home/vagrant/.emacs.d
  cd /home/vagrant/.emacs.d
  git reset --hard 0562f050b4b56470dc68744667794b20abe9570a
  wget -O /home/vagrant/.spacemacs https://raw.githubusercontent.com/nhsevidence/dotfiles/e21495af8ff8ac9b4b205f83959e5f8e34a1971c/.spacemacs
  chown -R vagrant /home/vagrant/.emacs.d /home/vagrant/.spacemacs
}

function install_tmux() {
  sudo apt-get install -y zsh
}

function install_tmux() {
  sudo apt-get install -y vim tmux
}

function main(){
  apt-get update
  apt-get install -y wget

  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
  echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
  
  apt-get update
  apt-get install -yy mono-devel ca-certificates-mono fsharp mono-vbnc nuget
  apt-get install -yy monodevelop monodevelop-nunit
  apt-get install -yy git raptor-utils make g++ compizconfig-settings-manager

  install_emacs24-5
  install_spacemacs
  install_sublime
  install_docker
  install_zsh  

  install_docker_compose
  install_docker_machine
  install_rancher_compose

  install_tmux

  apt-get clean
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

  chown -R vagrant /home/vagrant
}

main
