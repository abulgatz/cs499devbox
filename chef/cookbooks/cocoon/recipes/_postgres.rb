# node.set['postgresql']['password']['postgres']

include_recipe 'postgresql::server'
# include_recipe 'postgresql::ruby'
include_recipe 'database::postgresql'


postgresql_connection_info = {
	:host => "127.0.0.1",
	:port => node['postgresql']['config']['port'],
	:username => 'postgres',
	:password => node['postgresql']['password']['postgres']
}

# postgresql_connection_info = {
# 	:host     => 'localhost',
# 	:port     => 5432,
# 	:username => 'postgres',
# 	:password => 'password'
# }

# Create database
postgresql_database 'igp_development' do
	connection postgresql_connection_info
	action     :create
end

# create a postgresql user but grant no privileges
postgresql_database_user 'igp' do
	connection postgresql_connection_info
	password 'password'
	action :create
end

# grant all privileges on all tables in foo db
postgresql_database_user 'igp' do
  connection postgresql_connection_info
  database_name 'igp_development'
  privileges [:all]
  action :grant
end

# postgresql_database_user "grant permissions to foo_user" do
# 	connection    postgresql_connection_info
# 	username      'foo_user'
# 	database_name 'foo'
# 	action        :grant
# 	privileges    [:all]
# end