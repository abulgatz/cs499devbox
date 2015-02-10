Vagrant.configure('2') do |config|
  config.vm.box = 'chef/ubuntu-14.04'
  config.omnibus.chef_version = :latest

  config.vm.network :private_network, type: 'dhcp'
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.synced_folder './code', '/home/vagrant/code', nfs: true

  # config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]
  config.ssh.forward_agent = true

  config.berkshelf.enabled = true

  config.vm.provision :chef_zero do |chef|
    chef.cookbooks_path = 'chef/cookbooks'
    chef.data_bags_path = 'chef/databags'
    chef.add_recipe 'ssh_known_hosts'
    chef.add_recipe 'cocoon'
  end
end
