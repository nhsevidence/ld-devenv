#!/usr/bin/env bash

function install_docker_compose(){
  curl -L https://github.com/docker/compose/releases/download/1.3.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
}


function install_emacs24-4(){
  emacs --version
  if [ $? -ne 0 ]; then
    apt-get install -yy build-essential libgtk2.0-dev libgif-dev libjpeg62-dev libpng12-dev libxpm-dev libncurses-dev
    apt-get build-dep emacs24
    wget http://ftp.gnu.org/gnu/emacs/emacs-24.4.tar.gz
    tar -xzvf emacs-24.4.tar.gz
    rm emacs-24.4.tar.gz
    cd emacs-24.4
    ./configure --prefix=/opt/emacs --with-tiff=no
    make && make install
    cd ..
    ln -s /opt/emacs/bin/emacs-24.4 /usr/local/bin/emacs
  fi
}

function install_spacemacs(){
  git clone --recursive https://github.com/syl20bnr/spacemacs /home/vagrant/.emacs.d
  wget -O /home/vagrant/.spacemacs https://raw.githubusercontent.com/ryansroberts/dotfiles/master/.spacemacs
  chown -R vagrant /home/vagrant/.emacs.d /home/vagrant/.spacemacs
}

function main(){
  apt-get update
  apt-get install -y wget

  apt-get update && apt-key adv --keyserver pgp.mit.edu --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

  echo "deb http://download.mono-project.com/repo/debian wheezy/snapshots/3.12.0 main" > /etc/apt/sources.list.d/mono-xamarin.list
  apt-get update
  apt-get install -yy mono-devel ca-certificates-mono fsharp mono-vbnc nuget
  apt-get install -yy default-jre git graphviz raptor-utils python make g++ inotify-tools pandoc  nodejs npm

  install_emacs24-4
  install_spacemacs

  npm install -g grunt
  ln /usr/bin/nodejs /usr/bin/node

  install_docker_compose

  apt-get clean
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
}

main
