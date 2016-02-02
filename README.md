# Linked-data development environment

This project contains the virtualised development environment for the NICE linked data projects.  The environment is an ubuntu 14.04 LTS desktop virtual machine with all development tool dependancies (docker, nodejs, f#, mono) installed along with the spacemacs editor.

## Setting up with Vagrant

### Prerequisites

You will need to have the following software installed on your development machine: 
* Virtualbox (It works with >= 4 but i recommend 5 to maximise compatibility with the version of guest additions - version 5 -  installed on the vm)
* Vagrant (>= 1.7.4)

I suggest you use your native/favourite package manager to install these (for windows see [chocolately](https://chocolatey.org/), Mac OSX: [homebrew](), linux: apt-get :))

## Using the prebuild box

Grab the prebuild box from O:\KnowledgeBase-QS\ld-devenv.box (this is currently an NICE internal only link) and put it somewhere on your machine.  Open a command prompt/terminal in this directory and run:

```
vagrant box add ld-devenv.box
```

### Specifiy a shared folder between host and guest vm (optional)


To specify a folder to share set the environment variables VAGRANT_SYNC_SRC and VAGRANT_SYNC_DEST before running the vagrant up command.  This is recommended if you dont want to worry about losing work if there is a problem with your vm/virtualbox.
For example to share a src directory from C:\src to /src in the vm you need to set:

```
set VAGRANT_SYNC_SRC=C:\src
set VAGRANT_SYNC_DEST=/src
```

Now run up the environment:

Open a command prompt/terminal in the root of this repository and run:

```
vagrant up
```

## Or, build the environment from scratch

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

## Important points

Dont forget to set your git config user and email!  You will want to fix redraw issues if you encounter the screen not updating properly (see section below).

## Fixing redraw issues
Within ubuntu press the launch command button at the top left of the task bar (in its original position).  Then type 'cssm' to launch the Compiz Config Settings manager.  Click on 'Utility' -> 'WorkArounds' (click the label here) -> 'Force full screen redraws on repaint'.  No need save, just close the window.  Redraws should be fixed.

## For Mac Users
If you are setting this up on a mac for the first time with virtualbox you may find the left command key unresponsive in the VM.  This is due to virtualbox using it as a host key.  To resolve simply go to virtualbox -> preferences.  Input tab -> Virtual machine and change the host key to the right command (or whatever is desired).  The VM should then instantly map the left command key to ctrl.

### Troubleshooting

This has been tested with Virtualbox 5.0.4.102546 and Vagrant 1.7.4 but may work with earlier/later versions

#### Docker issues
If you have problems with docker run saying the daemon is not running or permissions issues, log out of the ubuntu vm and log back in again
