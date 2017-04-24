# Ansible_TestEnv

## Installing Homebrew (macOS)

``` bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Installing Vagrant (and virtual box) via Homebrew

### Install steps

Update Brew:

``` bash
brew update && brew upgrade
```

Install virtualbox:

``` bash
brew cask install virtualbox
```

Install vagrant:

``` bash
brew cask install vagrant
```

### Installation Verification

Verify virtualbox is installed:

``` bash
type -a vboxmanage
```

Example output:

``` bash
06:25 Mac Shell: .vagrant/>$ type -a vboxmanage
vboxmanage is /usr/local/bin/vboxmanage
06:25 Mac Shell: .vagrant/>$
```

Verify vagrant is installed:

``` bash
type -a vagrant
```

Example output:

``` bash
06:27 Mac Shell: .vagrant/>$ type -a vagrant
vagrant is /usr/local/bin/vagrant
06:27 Mac Shell: .vagrant/>$
```

## Install Ansible on your local machine (optional)

This step is optional because you could always install Ansible on one of the vagrant Testing servers and scp over the contents of the 'Ansible' directory.

### Installation with Brew:

``` bash
brew install ansible
```

### Installation with python:

Install pip:

``` bash
sudo easy_install pip
```

Install Ansible via `pip`:

``` bash
sudo pip install ansible
```

## Giting this repo

### Creating Git Directory

Recommend creating a git directory under your home directory:

``` bash
cd "$HOME"; mkdir Git;
```

### Cloning the repo to the local machine

Git a clone of the repo:

``` bash
git clone https://github.com/ScriptMyJob/ScriptMyJob_Ansible_TestEnv
```

## Starting Vagrant (Env1)

Change Directory to Vagrant Directory:

``` bash
cd "$HOME/Git/ScriptMyJob_Ansible_TestEnv/Vagrant/Env1"
```

Provision Vagrant VMs:

``` bash
vagrant up
```

## Testing Ansible via Ping Module

Change Directory to the Anisble Directory

``` bash
cd "$HOME/Git/ScriptMyJob_Ansible_TestEnv/Ansible/Env1"
```

It is recommended that you disable host key checking for your testing environment since these testing servers will likely be created and destroyed multiple times.  This can be done vai:

``` bash
export ANSIBLE_HOST_KEY_CHECKING=False
```

Verify communication and become access:

``` bash
ansible all -i inventory_file -m ping -b
```

Where:

``` bash
all : refers all vms specified in this file
-i  : specifies the inventory file
-m  : specifies the module
-b  : specifies using become (replacement for --sudo)
```
## Executing an Ansible Playbook:

Change Directory to the Anisble playbook Directory

``` bash
cd "$HOME/Git/ScriptMyJob_Ansible_TestEnv/Ansible/Env1/playbooks"
```

Provision Nginx and MySQL on web and database servers respectively:

``` bash
ansible-playbook provision_web_db.yaml
```

## Destroying a Vagrant Test Environment

Change the current working directory back to the main Vagrant directory:

``` bash
cd "$HOME/Git/ScriptMyJob_Ansible_TestEnv/Vagrant/Env1"
```

Deprovision Vagrant VMs

``` bash
vagrant destroy -f
```
