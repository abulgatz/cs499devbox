
# Cookbook Name:: cocoon
# Recipe:: default
#
# Copyright (C) 2014 FullStack
#

include_recipe 'cocoon::_dependencies'

include_recipe 'cocoon::_ruby'
include_recipe 'cocoon::_postgres'
include_recipe 'cocoon::_node'
include_recipe 'cocoon::_git'

include_recipe 'cocoon::clone_project'