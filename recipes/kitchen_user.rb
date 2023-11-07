#
# Cookbook:: deploy-context
# Recipe:: kitchen_user
#
# Copyright:: 2023, The Authors, All Rights Reserved.

include_recipe 'os-hardening'

platform_deploy 'system' do
  context_databag node[cookbook_name]['context_databag']
  secret_key node[cookbook_name]['secret_key']
  chef_accept node[cookbook_name]['chef_accept']
  action %w(setup) + node[cookbook_name]['system']['deploy'].map {|set_user| "deploy_#{set_user}_user"}
end

user_deploy 'vagrant' do
  home '/home/vagrant'
  owner 'vagrant'
  group 'vagrant'
  context_databag node[cookbook_name]['context_databag']
  secret_key node[cookbook_name]['secret_key']
  action %w(setup) + node[cookbook_name]['user']['deploy'].map {|set_user| "deploy_#{set_user}_user"}
end

include_recipe '::workstation'

# deploy_context 'vagrant' do
#   parent_path '/home/vagrant'
#   action [:build_habitat, :build_kitchen, :build_cucumber, :build_inspec]
#   skip_failure true
#   chef_repo_name node[cookbook_name]['chef_repo_name']
#   chef_repo_git node[cookbook_name]['chef_repo_git']
# end
