# name 'Resource file for chef_workstation_initialize'
# maintainer 'Jimbo Dragon'
# maintainer_email 'jimbo_dragon@hotmail.com'
# license 'MIT'
# description 'Resource file for chef_workstation_initialize'
# version '0.1.0'
# chef_version '>= 16.6.14'
# issues_url 'https://github.com/jimbodragon/chef_workstation_initialize/issues'
# source_url 'https://github.com/jimbodragon/chef_workstation_initialize'

# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/

resource_name :platform_deploy
provides :platform_deploy

property :platform_name, String, name_property: true
property :context_databag, String
property :secret_key, String
property :chef_accept, Hash, default: Hash.new
property :kitchen_workstation, String

default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  system_user :setup
end

action :planning do
  system_user :planning
end

action :deploy_git_user do
  system_user :deploy_git_user
end

action :deploy_ssh_user do
  system_user :deploy_ssh_user
end

action :deploy_chef_user do
  system_user :deploy_chef_user

  licenses_dir = '/etc/chef/accepted_licenses'

  directory licenses_dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
  
  new_resource.chef_accept.each do |license_key, raw_license|
    accept_chef_license(::File.join(licenses_dir, license_key), raw_license)
  end
end

action :deploy_gem_user do
  system_user :deploy_gem_user
end

action :deploy_habitat_user do
  system_user :deploy_habitat_user
end

action :deploy_circleci_user do
  system_user :deploy_circleci_user
end

action :deploy_docker_user do
  system_user :deploy_docker_user
end

action :deploy_aws_user do
  system_user :deploy_aws_user
end

action :deploy_cucumber_user do
  system_user :deploy_cucumber_user
end

action_class do
  def system_user(action)
    user_deploy 'root' do
      home '/root'
      owner 'root'
      group 'root'
      context_databag new_resource.context_databag
      secret_key new_resource.secret_key
      kitchen_workstation new_resource.kitchen_workstation
      action action
    end
  end

  def accept_chef_license(accept_file, raw_license)
    converge_by("Setting Chef license for #{accept_file} ") do
      file accept_file do
        content raw_license
        owner 'root'
        group 'root'
        mode '0755'
        action :create
      end
    end
  end
end ## end action_class
