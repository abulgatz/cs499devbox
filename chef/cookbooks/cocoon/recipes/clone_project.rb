#
# Cookbook Name:: cocoon
# Recipe:: _ruby
#
#

#
# Clones the rails project
#

directory "/home/vagrant/code" do
  recursive true
  action :delete
end

git "/home/vagrant/code" do
	repository "git@github.com:railstutorial/sample_app.git"
	reference "master"
	action :checkout
	# user "vagrant"
end