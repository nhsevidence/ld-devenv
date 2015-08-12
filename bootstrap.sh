#!/usr/bin/env bash

main(){
  apt-get update && apt-key adv --keyserver pgp.mit.edu --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

  echo "deb http://download.mono-project.com/repo/debian wheezy/snapshots/3.12.0 main" > /etc/apt/sources.list.d/mono-xamarin.list
  apt-get update
  apt-get install -yy mono-devel ca-certificates-mono fsharp mono-vbnc nuget
  apt-get install -yy default-jre git graphviz raptor-utils python make g++ inotify-tools pandoc  nodejs npm
  apt-get install -yy luatex lmodern texlive-latex-base texlive-latex-extra texlive-fonts-recommended
  npm install -g grunt
  ln /usr/bin/nodejs /usr/bin/node
  apt-get clean
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

  print_super_crab
}

function print_super_crab(){
  echo "   _      _  " 
  echo "  (<      >) "
  echo "   'O,99,O'  "
  echo "  //-\__/-\\ " 
  echo "Dev environment ready!"
}

