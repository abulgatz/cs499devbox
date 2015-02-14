# Windows Rails, Git, Vagrant, on Windows

## Install VirtualBox

Install [VirtualBox](https://www.virtualbox.org/)

## Install Vagrant

Install [Vagrant](http://vagrantup.com)

Vagrant (ruby really) does't like home directories with spaces. To be safe (and consistent), we're going to move our Vagrant home directory to `C:\HashiCorp\Vagrant\home`

First, create a "home" folder in `C:\HashiCorp\Vagrant`, then in a command prompt run:

	$ setx VAGRANT_HOME "C:\HashiCorp\Vagrant\home"

<!--

NOTE: This adds to the User Environment, if you want to add to the system/machine you need to add the /M option at the end of the command in an elevated command prompt, for example:

	$ setx VAGRANT_HOME "C:\HashiCorp\Vagrant\home" /M

-->

## Install the Chef Development Kit

<!--
If you have a mac, first install homebrew, then

    $ brew install caskroom/cask/brew-cask
    $ brew cask install chefdk
-->

Install the [Chef Development Kit](https://downloads.chef.io/chef-dk/)

Add binaries to PATH, see: [The ChefDK on Windows Survival Guide](https://www.chef.io/blog/2014/11/04/the-chefdk-on-windows-survival-guide/)

## Install Vagrant plugins

```bash
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-omnibus
```

## Configure Git on Windows

Install [Git for Windows](http://git-scm.com/download/win)

### Step 1: Check for SSH keys

Open up your Git Bash and check for existing SSH keys on your computer

```bash
$ ls -al ~/.ssh
# Lists the files in your .ssh directory, if they exist
```

Check the directory listing to see if you already have a public SSH key. The default public key file names are:

* id_dsa.pub
* id_ecdsa.pub
* id_ed25519.pub
* id_rsa.pub

If not, then you will generate a new one. To generate a new SSH key, copy and paste the text below, making sure to substitute in your email address. The default settings are preferred, so when you're prompted to "Enter a file in which to save the key", just press Enter to continue.

### Step 2: Generate a new SSH key

```bash	
$ ssh-keygen -t rsa -C "your_email@example.com"
# Creates a new ssh key, using the provided email as a label
Generating public/private rsa key pair.
Enter file in which to save the key (/c/Users/you/.ssh/id_rsa): [Press enter]
Enter passphrase (empty for no passphrase): [Type a passphrase]
Enter same passphrase again: [Type passphrase again]
```

Which should give you something like this:

```bash
Your identification has been saved in /c/Users/you/.ssh/id_rsa.
Your public key has been saved in /c/Users/you/.ssh/id_rsa.pub.
The key fingerprint is:
01:0f:f4:3b:ca:85:d6:17:a1:7d:f0:68:9d:f0:a2:db your_email@example.com
```

Then add your new key to the ssh-agent:

```bash
$ eval $(ssh-agent)
# Start the agent. Can also use: eval `ssh-agent`
Agent pid 7882
$ ssh-add
# Add your key. This will default to adding ~/.ssh/id_rsa and ~/.ssh/id_dsa.
Enter passphrase for ~/.ssh/id_rsa: ••••••••••••••••••
Identity added: ~/.ssh/id_rsa (~/.ssh/id_rsa)
$ ssh-add -l
# (Optional:) Test that your key is unlocked in the agent.
```

### Step 3: Add your SSH key to your account

Run the following command to copy the key to your clipboard.

```bash
clip < ~/.ssh/id_rsa.pub
# Copies the contents of the id_rsa.pub file to your clipboard
```

Alternatively, using your favorite text editor, you can open the public key file and copy the contents of the file manually.

Now that you have the key copied, it's time to add it to GitHub:

1. In the top right corner of any page, click the gear icon
2. In the user settings sidebar, click SSH keys.
3. Click Add SSH key.
4. In the Title field, add a descriptive label for the new key. For example, if you're using a personal Mac, you might call this key "Personal MacBook Air".
5. Paste your key into the "Key" field.
6. Click Add key.
7. Confirm the action by entering your GitHub password.

### Step 4: Test everything out

Open up your Git Bash and type:

```bash
ssh -T git@github.com
# Attempts to ssh to GitHub
```

You may see this warning:

```bash
# The authenticity of host 'github.com (207.97.227.239)' can't be established.
# RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
# Are you sure you want to continue connecting (yes/no)?
```

Don't worry! This is supposed to happen. Verify that the fingerprint in your terminal matches the one we've provided up above, and then type "yes."

```bash
# Hi username! You've successfully authenticated, but GitHub does not
# provide shell access.
```

If that username is yours, you've successfully set up your SSH key! Don't worry about the "shell access" thing, you don't want that anyway.

If you receive a message about "access denied," you can [read these instructions for diagnosing the issue](https://help.github.com/articles/error-permission-denied-publickey).

## Configure SSH keys

Your ssh keys are in openssh format, which PuTTY, the Windows SSH client that we will be using, can't read. We will use PuTTYgen to convert them to a format that putty can read.

Download and install [PuTTY](http://the.earth.li/~sgtatham/putty/latest/x86/putty-0.63-installer.exe), which will include PuTTY, Pageant, and PuTTYgen.

### Convert SSH keys

Open PuTTYgen

Click "Load", change the filetype to "All Files" browse to `C:\username\.ssh\id_rsa`, and click "Open". Click "Save Private Key", and save into the same folder with the name `id_rsa.ppk`. Make sure you add the ".ppk" extension.

Complete the same process with `C:\HashiCorp\Vagrant\home\insecure_private_key`, saving as `insecure_private_key.ppk`

### Load SSH keys

Make a shortcut to Pageant on your desktop

Right click on the shortcut and click Properties. Go to the "Shortcut" tab add the following at the end of "Target" (make sure to add a space between the end of what is there and what you copy in):

    "%HOMEPATH%\.ssh\id_rsa.ppk" "C:\HashiCorp\Vagrant\home\insecure_private_key.ppk"

You can then copy this shortcut to your startup folder at `C:\Users\<User Profile folder name>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`

## Download devbox respository

```bash
$ git clone git@github.com:abulgatz/cs499devbox.git
$ cd cs499devbox
```

## Run dev box

```bash
$ vagrant up
```

## PuTTY Settings

* Hostname: 127.0.0.1
* Port: 2222
* Connection > data > auto login name: vagrant
* Session > Saved Sesstion: vagrant
	* Click Save
	
In the future, select the saved "vagrant" under Saved sessions and click "Load"

Click "Open" to open the connection



## Start Rails Server

```bash
bundle install
rails s -b 0.0.0.0
```