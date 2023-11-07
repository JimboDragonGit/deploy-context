#
# Cookbook:: deploy-context
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

# deployer = Context::DeployContext.deployer
# deployer.cucumber

chef_ingredient 'chef-workstation' do
  architecture 'x86_64'
end

apt_update 'workstation' do
  action :update
end

build_essential

gems_list = %w(
  cucumber
  knife-ec2
  kitchen-vagrant
  kitchen-dokken
  kitchen-ec2
  ruby-shadow
)

gems_list.each do |e|
  chef_gem e
end

chef_gem 'cucumber'
chef_gem 'knife-ec2'
chef_gem 'kitchen-vagrant'
chef_gem 'kitchen-dokken'
chef_gem 'kitchen-ec2'
chef_gem 'ruby-shadow'

chef_gem 'deploy-context'
