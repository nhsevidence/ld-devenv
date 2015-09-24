# Linked-data development environment

This project contains the virtualised development environment for the NICE linked data projects.  The environment is an ubuntu 14.04 LTS desktop virtual machine with all development tool dependancies (docker, nodejs, f#, mono) installed along with the spacemacs editor.

## Setting up with Vagrant

### Prerequisites

You will need to have the following software installed on your development machine: 
* Virtualbox (It works with >= 4 but i recommend 5 to maximise compatibility with the version of guest additions - version 5 -  installed on the vm)
* Vagrant (>= 1.7)

I suggest you use your native/favourite package manager to install these (for windows see [chocolately](https://chocolatey.org/), Mac OSX: [homebrew](), linux: apt-get :))

## Creating the environment from scratch

Open a command prompt/terminal in the root of this repository and run:
```
vagrant up
```
The ubuntu login window will appear but don't login until the above command has finished as this will be installing stuff.  Once finished, login to ubuntu with user/pass: *vagrant*.

Now open a terminal inside you ubuntu vm and type: 
```
emacs
```
to launch spacemacs.  This will install a load of plugins on first load but will be quicker on subsequent loads.


### Troubleshooting

This has been tested with Virtualbox 5 and Vagrant 1.7.3 but may work with earlier/later versions

#### Docker issues
If you have problems with docker run saying the daemon is not running or permissions issues, log out of the ubuntu vm and log back in again
