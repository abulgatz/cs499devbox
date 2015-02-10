#
# Cookbook Name:: cocoon
# Recipe:: _dependencies.rb
#
# Copyright (C) 2015 mls
#

#
# Update dependencies to prevent unneseccery 404s.
#
execute 'apt-get update' do
  ignore_failure true
end
