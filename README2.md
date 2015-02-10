# Windows Rails, Git, Vagrant

## Install chefdk

If you have a mac, first install homebrew, then

    $ brew install caskroom/cask/brew-cask
    $ brew cask install chefdk

If you have a Windows machine, download from [https://downloads.chef.io/chef-dk/](https://downloads.chef.io/chef-dk/)

    $ vagrant plugin install vagrant-berkshelf

## Install Vagrant

Install Vagrant from [vagrantup.com](http://vagrantup.com)

Vagrant (ruby really) does't like home directories with spaces. To be safe (and consistent), we're going to move our Vagrant home directory to C:\HashiCorp\Vagrant\home

First, create a "home" folder in C:\HashiCorp\Vagrant, then in a command prompt run:

	$ setx VAGRANT_HOME "C:\HashiCorp\Vagrant\home"

NOTE: This adds to the User Environment, if you want to add to the system/machine you need to add the /M option at the end of the command in an elevated command prompt, for example:

	$ setx VAGRANT_HOME "C:\HashiCorp\Vagrant\home" /M

## Configure Git on Windows in Git Bash

First, we need to check for existing SSH keys on your computer. Open up your Git Bash and type:

	$ ls -al ~/.ssh
	# Lists the files in your .ssh directory, if they exist

Check the directory listing to see if you already have a public SSH key. The default public key file names are:

* id_dsa.pub
* id_ecdsa.pub
* id_ed25519.pub
* id_rsa.pub

To generate a new SSH key, copy and paste the text below, making sure to substitute in your email address. The default settings are preferred, so when you're prompted to "Enter a file in which to save the key", just press Enter to continue.
	
	$ ssh-keygen -t rsa -C "your_email@example.com"
	# Creates a new ssh key, using the provided email as a label
	Generating public/private rsa key pair.
	Enter file in which to save the key (/c/Users/you/.ssh/id_rsa): [Press enter]
	Enter passphrase (empty for no passphrase): [Type a passphrase]
	Enter same passphrase again: [Type passphrase again]

Which should give you something like this:

	Your identification has been saved in /c/Users/you/.ssh/id_rsa.
	Your public key has been saved in /c/Users/you/.ssh/id_rsa.pub.
	The key fingerprint is:
	01:0f:f4:3b:ca:85:d6:17:a1:7d:f0:68:9d:f0:a2:db your_email@example.com

Then add your new key to the ssh-agent:

	$ eval $(ssh-agent)
	# Start the agent. Can also use: eval `ssh-agent`
	Agent pid 7882
	$ ssh-add
	# Add your key. This will default to adding ~/.ssh/id_rsa and ~/.ssh/id_dsa.
	Enter passphrase for ~/.ssh/id_rsa: ••••••••••••••••••
	Identity added: ~/.ssh/id_rsa (~/.ssh/id_rsa)
	$ ssh-add -l
	# (Optional:) Test that your key is unlocked in the agent.

Add both keys to pageant

## Other stuff

pageant
puttygen
putty

ssh -T git@github.com
config.ssh.forward_agent = true

config.ssh.forward_agent = true
config.ssh.insert_key = false # forces use of insecure default key in ~/vagrant.d/
config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]