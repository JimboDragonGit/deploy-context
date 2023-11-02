#
# Cookbook:: deploy-context
# Recipe:: kitchen_user
#
# Copyright:: 2023, The Authors, All Rights Reserved.

user_deploy 'vagrant' do
  home '/home/vagrant'
  owner 'vagrant'
  group 'vagrant'
  ssh_private_key node[cookbook_name]['ssh_private_key'].split('\\n').join("\n")
  ssh_public_key node[cookbook_name]['ssh_public_key']
  gem_api node[cookbook_name]['gem_api']
  email node[cookbook_name]['email']
  full_name node[cookbook_name]['full_name']
end

# chef_gem "ruby-shadow"
# chef_gem 'deploy-context'

directory '/home/vagrant/.chef/plugins'

# link File.join('/home/vagrant', 'deploy-context') do
#   to '/home/vagrant/.chef/plugins/knife'
#   link_type :symbolic
# end

deploy_context 'vagrant' do
  parent_path '/home/vagrant'
end

include_recipe '::workstation'
