#!/usr/bin/env bash

function install_docker(){
  docker --version
  if [ $? -ne 0 ]; then
    wget -qO- https://get.docker.com/ | sh
    sudo usermod -aG docker vagrant
  fi
}

function install_rancher_server(){
   RANCHER_SERVER_VERSION=v0.56.1
   sudo docker run -d --restart=always -p 8080:8080 rancher/server:$RANCHER_SERVER_VERSION
}

function main(){
  install_docker
  install_rancher_server
}

main

echo "   _      _  " 
echo "  (<      >) "
echo "   'O,99,O'  "
echo "  //-\__/-\\ " 
echo "Dev environment ready!"
