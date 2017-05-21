Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-16.04'
  config.omnibus.chef_version = :latest


  config.vm.network :private_network, type: 'dhcp'
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.synced_folder './code', '/home/vagrant/code', nfs: true

  config.vm.provider "virtualbox" do |v|
    v.name = "rails_vm"
    v.memory = 1024
    v.cpus = 2
  end

  # config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]

  config.ssh.insert_key = false # false forces use of insecure default key in ~/vagrant.d/
  config.ssh.forward_agent = true

  config.berkshelf.enabled = true

  config.vm.provision :chef_zero do |chef|
    chef.cookbooks_path = 'chef/cookbooks'
    chef.data_bags_path = 'chef/databags'
    chef.nodes_path = 'chef/cookbooks'
    chef.channel = 'stable'
    chef.version = '12.10.24'

    chef.json = {
      "postgresql" => {
        "password" => {
          "postgres" => "password"
        }
      },
    }

    chef.add_recipe 'apt'
    chef.add_recipe 'postgresql'
    # chef.add_recipe 'postgresql::server'
    # chef.add_recipe 'postgresql::ruby'
    # chef.add_recipe 'database::postgresql'
    chef.add_recipe 'ssh_known_hosts'
    chef.add_recipe 'cocoon'
  end
end
