# Linked-data development environment

This project contains the virtualised development environment for the
NICE linked data projects.
It's an Ubuntu 16.04 LTS desktop virtual machine with several
programming languages, runtimes and development tools installed.
It's configured using [Vagrant](https://www.vagrantup.com) and
 [Ansible](https://docs.ansible.com/).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [What's in the box](#whats-in-the-box)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [Generate SSH keys](#generate-ssh-keys)
  - [Prepackaged Virtual Machine Setup](#prepackaged-virtual-machine-setup)
  - [Development environment box updating](#development-environment-box-updating)
- [Usage](#usage)
  - [Virtual Machine Setup](#virtual-machine-setup)
    - [Copy SSH keys](#copy-ssh-keys)
    - [Run the environment](#run-the-environment)
    - [Post-setup](#post-setup)
      - [Setup Git username and email](#setup-git-username-and-email)
      - [Share folders between host and guest VM (optional)](#share-folders-between-host-and-guest-vm-optional)
      - [Setup Rancher container service (optional)](#setup-rancher-container-service-optional)
- [Troubleshooting](#troubleshooting)
  - [For Windows users](#for-windows-users)
  - [For Mac Users](#for-mac-users)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## What's in the box

- Base Box
    - [Bento project](https://app.vagrantup.com/bento)
[Ubuntu 16.04 LTS](https://app.vagrantup.com/bento/boxes/ubuntu-16.04/versions/201806.08.0)
- Languages and runtimes
    - [Node.js 8.x](https://nodejs.org/en/)
    - [Mono 5.x](http://www.mono-project.com/)
    - [F Sharp 4.x](https://fsharp.org/)
    - [Python 2.7.x](https://www.python.org/)
- IDEs and editors
    - [Sublime Text 3](https://www.sublimetext.com/)
    - [MonoDevelop 7](http://www.monodevelop.com/)
- Dev tools
    - [Git 2.x](https://git-scm.com/)
    - [NuGet 4](https://www.nuget.org/)
    - [Fish shell](https://fishshell.com/) - default shell
    - [zsh](http://zsh.sourceforge.net/)
- Containerisation
    - [Docker 17.03.2](https://docs.docker.com/)
    - [Docker Compose 1.21.2](https://docs.docker.com/compose/overview/)
    - [Rancher 1.6](https://rancher.com/docs/rancher/v1.6/en/)
    - [Rancher Compose 0.12.5](https://rancher.com/docs/rancher/v1.6/en/cattle/rancher-compose/)

## Prerequisites
You will need to have the following software installed on your development machine:
- [Virtualbox v5.x](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant v2.1.2](https://www.vagrantup.com/downloads.html) NOTE: You will need to deactivate Hyper-V (if enabled) before installing Vagrant.
- [SSH keys (see below)](#generate-ssh-keys)

## Setup

### Generate SSH keys

- Follow [these instructions](https://help.github.com/articles/connecting-to-github-with-ssh/) to
generate your SSH keys (if needed) and adding them to Github


### Prepackaged Virtual Machine Setup

A prepackaged box has been made available which has all the software
installed and rancher already configured.

- OPTIONAL: To add a shared folder, create one (e.g. 'C:\_src\Shared'). Navigate to the '_src\ld-devenv\prepackaged' directory and open 'Vagrantfile' in a text editor. Uncomment and change the property `config.vm.synced_folder` to the desired folder in
your host (left side path)
	```
	config.vm.synced_folder "C:\\_src\\Shared", "/home/vagrant/Shared"
	```

- Go to `O:\ld-devenv` (DS network) and copy the `ld-devenv.box` file to a directory of your choice, e.g. `C:\_src`

- Open a command prompt/terminal and go to that directory
    ```
    cd C:\_src
    ```

- In the command prompt/terminal run
    ```
    vagrant box add --name ld-devenv ld-devenv.box
    ```


### Development environment box updating

If you want to update the ld-devenv.box file, change your VM as needed,
open a command prompt/terminal in the root of this repository and run
the following:

```
vagrant package --output ld-devenv.box
```

Go to `O:\ld-devenv` (DS network) and replace the `ld-devenv.box` file with the
updated file.


## Usage

You can setup your own VM or use a prepackaged box.
See below for details on how to use each of these options.

### Virtual Machine Setup

#### Copy SSH keys

- Copy your Github private and public keys to the root directory of this repository
- Rename the keys to `id_rsa` and `id_rsa.pub` respectively

#### Run the environment

On your host, open a command prompt/terminal and go the `Prepackaged` directory in this this repository and run the following:

- Setup up the environment. The guest VM will start and and Ansible
will setup the environment.
    ```
    vagrant up
    ```
- After the environment setup has finished you should the number of
successful steps done
    ```
    ld-devenv  :  ok=36
    ```
- Restart the environment to use the Ubuntu GUI
    ```
    vagrant halt
    vagrant up
    ```
- Login into Ubuntu
    - Select the `vagrant` user
    - Use `vagrant` as the password
	
- To use the environment at any time do
    ```
    vagrant up
    ```

#### Post-setup

##### Setup Git username and email

Open a terminal in your guest VM and do the following:

- Set git username
    ```
    git config --global user.name "{Same as GitHub profile name}"
    ```
- Set git email
    ```
    git config --global user.email "{Same as GitHub email}"
    ```
- Check if the config is correct
    ```
    git config --global user.name
    git config --global user.email
    ```

##### Share folders between host and guest VM (optional)

You can share folders between the host and the guest VM.

- In your VM menu go to `Devices -> Insert Guest Additions CD image...`.
You should see a CD autorun in your VM

- Click `Run` and input `vagrant` as a password when requested.
You should see a terminal installing the Guest Additions

- Edit the `Vagrantfile` at the root of this repo. Uncomment and
change the property `config.vm.synced_folder` to the desired folder in
your host (left side path)

- Reload the VM by doing `vagrant reload` in your host

- The contents of your shared folder should appear in the `Shared`
folder of the guest's `Home` directory

- Copy your [SSH keys](#generate-ssh-keys) to `/home/vagrant/.ssh`. 
(The `.ssh` directory is hidden by default in the vagrant user `Home` directory.
In your guest file manager go to *View -> Show Hidden Files* to see it. This is not on the VM window menu, but the one below it. The files can be copied via the shared folder if needed.)


##### Setup Rancher container service (optional)

The Rancher server is installed automatically but you will need to do a
little manual setup to install the rancher agent before using rancher.
Do the following to setup a rancher host:

- Check that Rancher is running in docker. You should see a `rancher/server`
container running on port `8888`
    ```
    docker ps -f name=rancher
    ```
- Find the docker IP by doing the following and getting the `inet addr`
    ```
    ifconfig | grep docker0 -A 1
    ```
- Go to the following URL in your guest VM browser, where the IP is the
one above, e.g.:
    ```
    http://172.17.0.1:8888
    ```
- Click on *Infrastructure -> Hosts -> Add Host*
- You will be prompted the first time to enter your Host Registration URL.
Make sure it's the same as the one above and click *Save*.
- Select a new *'Custom'* host and follow the instructions on the page,
copying, pasting and running the displayed command in the terminal.
- When you click *Close* on the Rancher UI, you will be directed back to
the Infrastructure -> Hosts view, where the host will automatically appear.


## Troubleshooting

### For Windows users
- The VM might lose its network connection if your Windows machine goes to sleep.

    If that happens on your host, open a command prompt/terminal in the
    root of this repository and run the following:

    ```
    vagrant halt
    vagrant up
    ```

- Gedit (the default text editor) isn't able to save files to shared folders.

    Use Sublime Text or Mono Develop when editing files in the shared folders.
	
- If Hyper-V is installed, deactivate it before continuing

### For Mac Users
If you are setting this up on a mac for the first time with virtualbox
you may find the left command key unresponsive in the VM.
This is due to virtualbox using it as a host key.

To resolve simply go to
*Virtualbox -> Preferences -> Input tab -> Virtual machine tab*
and change the *Host Key Combination* to the right command (or whatever is desired).
The VM should then instantly map the left command key to ctrl.

