# Linked-data development environment

This project contains the virtualised development environment for the NICE linked data projects.  The environment is an ubuntu 14.04 LTS desktop virtual machine with all development tool dependancies (docker, nodejs, f#, mono) installed along with the spacemacs editor.  It also includes [Rancher](http://rancher.com/rancher/) docker container service software.

## Setting up with Vagrant

### Prerequisites

You will need to have the following software installed on your development machine: 
* Virtualbox (It works with >= 4 but i recommend 5 to maximise compatibility with the version of guest additions - version 5 -  installed on the vm)
* Vagrant (>= 1.7.4)

You will also need your id_rsa & id_rsa.pub files setup [Seting up ssh keys](https://help.github.com/articles/generating-an-ssh-key/)

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

## Setting up Rancher container service

Currently the Rancher server is installed automatically and should be visible on localhost:8080. 
You will need to do a little manual setup to install the rancher agent before using rancher.

### Configuring rancher agent
Goto url in your browser within your VM

```
localhost:8080
```

Now click on *Infrastructure -> Hosts -> Add Host*.  You will be prompted the first time to enter your Host Registration URL, which is different from localhost.  You need to get the ip address of the docker container running the rancher server.  You can do this using:
```
docker ps
docker inspect <name_of_container_running_rancher_server> | grep IPAddress
```
Now paste the IP for the rancher container into the custom URL box (dont forget the port!).  It should be something like http://172.17.0.2:8080.  Now click save.
You should now select a new *'Custom'* host and grab the command it produces for you.  This command will be unique to your setup and contains gdynamically generated codes.  Which loooks something like this (you will need to modify it though, see below):
```
sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 http://172.17.0.2:8080/v1/scripts/2D4EB6D9DFA6BE1E61D5:1454670000000:5scsHZbSvsPruECHdQVTN2YE7E
```

Since we are adding a host that is running Rancher server, we need to edit the command and insert -e CATTLE_AGENT_IP=<server_ip> into the command, where <server_ip> is the IP address of the Rancher server host.

In our example, <server_ip> is 172.17.0.2, we will update the command to add in setting the environment variable.

```
sudo docker run -e CATTLE_AGENT_IP=172.17.0.2 -d --privileged -v /var/run/docker.sock:/var/run/docker.sock rancher/agent:v0.8.2 http://172.17.0.2:8080/v1/scripts/2D4EB6D9DFA6BE1E61D5:1454670000000:5scsHZbSvsPruECHdQVTN2YE7E
```

When you click Close on the Rancher UI, you will be directed back to the Infrastructure -> Hosts view. In a little bit, the host will automatically appear.


### Troubleshooting Rancher
You should be able to see the rancher server and agent running as docker containers within the VM:
```
docker ps
```
If they arent running, check the logs.

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
