#
# Clones the rails project
#

# Erase everything in the code folder
# directory "/home/vagrant/code" do
#   recursive true
#   action :delete
# end

git "/home/vagrant/code/igp" do
	repository "git@github.com:abulgatz/cs499igp.git"
	# reference "master"
	checkout_branch "development"
	action :checkout
	# user "vagrant"
end

execute 'cd /home/vagrant/code/igp && bundle install' do
  not_if 'bundle check'
end