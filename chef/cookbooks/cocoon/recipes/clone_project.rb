#
# Cookbook Name:: cocoon
# Recipe:: _ruby
#
#

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
	reference "master"
	action :checkout
	# user "vagrant"
end