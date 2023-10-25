#
# Cookbook:: deploy-context
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.


apt_update 'habitat' do
  action :update
end

build_essential

chef_gem 'cucumber'
chef_gem 'knife-ec2'
chef_gem 'kitchen-vagrant'
chef_gem 'kitchen-dokken'
chef_gem 'kitchen-ec2'

template '/etc/chef/client.rb' do
  source 'client.rb.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  variables chef_server_url: ENV['CHEF_SERVER_URL']
end
  
file '/etc/chef/validation.pem' do
  user 'root'
  mode '0755'
  content ENV['CHEFVALIDATORKEY']
end

user_deploy ENV['USER'] do
  home ENV['HOME']
  owner ENV['USER']
  group ENV['USER']
  ssh_private_key ENV['SSHPRIVATEKEY']
  ssh_public_key ENV['SSHPUBLICKEY']
  client_name ENV['CLIENT_NAME']
  client_key ENV['CLIENT_KEY']
  client_raw_key ENV['CLIENT_RAW_KEY']
  chef_server_url ENV['CHEF_SERVER_URL']
  gem_api ENV['GEMAPI']
  email ENV['EMAIL']
  full_name ENV['NAME']
end
