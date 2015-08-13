#!/usr/bin/env bash

function install_docker(){
  docker --version
  if [ $? -ne 0 ]; then
    wget -qO- https://get.docker.com/ | sh
    sudo usermod -aG docker vagrant
  fi
}

function main(){
  install_docker
}

main

echo "   _      _  " 
echo "  (<      >) "
echo "   'O,99,O'  "
echo "  //-\__/-\\ " 
echo "Dev environment ready!"