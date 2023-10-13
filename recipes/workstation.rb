#
# Cookbook:: deploy-context
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

# deployer = Context::DeployContext.deployer
# deployer.cucumber

chef_ingredient 'chef-workstation'

apt_update 'workstation' do
  action :update
end

build_essential

chef_gem 'cucumber'
chef_gem 'knife-ec2'
chef_gem 'kitchen-vagrant'
chef_gem 'kitchen-dokken'
chef_gem 'kitchen-ec2'
# chef_gem "ruby-shadow"
chef_gem 'deploy-context'

# git File.join(ENV['HOME'], 'deploy-context') do
#   repository 'git@github.com:JimboDragonGit/deploy-context.git'
#   revision 'master'
#   action :sync
# end
