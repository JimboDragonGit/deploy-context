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
  kitchen_workstation node[cookbook_name]['suite_kitchen']
  action %w(setup) + node[cookbook_name]['system']['deploy'].map {|set_user| "deploy_#{set_user}_user"}
end

user_deploy 'vagrant' do
  home '/home/vagrant'
  owner 'vagrant'
  group 'vagrant'
  context_databag node[cookbook_name]['context_databag']
  secret_key node[cookbook_name]['secret_key']
  kitchen_workstation node[cookbook_name]['suite_kitchen']
  action %w(setup) + node[cookbook_name]['user']['deploy'].map {|set_user| "deploy_#{set_user}_user"}
end

include_recipe '::workstation'

node[cookbook_name]['plans'].each do |plan_location|
  deploy_context 'root' do
    parent_path '/root'
    # action [:build_kitchen, :build_habitat, :build_inspec, :build_cucumber]
    skip_failure true
    chef_repo_name node[cookbook_name]['chef_repo_name']
    chef_repo_git node[cookbook_name]['chef_repo_git']
    organisation_name node[cookbook_name]['organisation_name']
    application_name node[cookbook_name]['application_name']
    suite_kitchen node[cookbook_name]['suite_kitchen']
    plan_path plan_location
  end
end
