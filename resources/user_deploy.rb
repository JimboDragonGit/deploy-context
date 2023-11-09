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

resource_name :user_deploy
provides :user_deploy

property :owner, String, name_property: true
property :home, String
property :group, String
property :context_databag, String
property :secret_key, String
property :kitchen_workstation, String


default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  load_dependencies
  @secret_info = set_secret(new_resource.owner, new_resource.home, new_resource.group, new_resource.secret_key)
end

action :planning do
  action_setup
end

action :deploy_git_user do
  action_planning
  git_user_deploy new_resource.owner do
    home new_resource.home
    group new_resource.group
    email secret_info['email']
    fullname secret_info['fullname']
  end
end

action :deploy_ssh_user do
  action_planning
  ssh_user_deploy new_resource.owner do
    home new_resource.home
    group new_resource.group
    github_ssh_private_key secret_info['github_ssh_private_key']
    github_ssh_public_key secret_info['github_ssh_public_key']
  end
end

action :deploy_chef_user do
  action_planning
  chef_user_deploy new_resource.owner do
    home new_resource.home
    group new_resource.group
    deploy_client_name secret_info['chef_client_name']
    deploy_server_url secret_info['chef_server_url']
    deploy_client_key secret_info['chef_client_key']
  end
end

action :deploy_gem_user do
  action_planning
  gem_user_deploy new_resource.owner do
    home new_resource.home
    group new_resource.group
    rubygems_api_key secret_info['rubygems_api_key']
  end
end

action :deploy_habitat_user do
  action_planning
  habitat_user_deploy new_resource.owner do
    home new_resource.home
    group new_resource.group
    kitchen_workstation new_resource.kitchen_workstation
    hab_auth_token secret_info['hab_auth_token']
    hab_origin secret_info['hab_origin']
    hab_license secret_info['hab_license']
  end
end

action :deploy_circleci_user do
  action_planning
  circleci_user_deploy new_resource.owner do
    home new_resource.home
    group new_resource.group
    circleci_token secret_info['circleci_token']
    circleci_api_token secret_info['circleci_api_token']
    circleci_org_optin secret_info['circleci_org_optin']
  end
end

action :deploy_docker_user do
  action_planning
  docker_user_deploy new_resource.owner do
    home new_resource.home
    group new_resource.group
    dockerhub_user secret_info['dockerhub_user']
    dockerhub_password secret_info['dockerhub_password']
  end
end

action :deploy_aws_user do
  action_planning
  aws_user_deploy new_resource.owner do
    home new_resource.home
    group new_resource.group
    aws_access_key_id secret_info['aws_access_key_id']
    aws_secret_access_key secret_info['aws_secret_access_key']
  end
end

action :deploy_cucumber_user do
  action_planning
  cucumber_user_deploy new_resource.owner do
    home new_resource.home
    group new_resource.group
    cucumber_publish_enabled secret_info['cucumber_publish_enabled']
    cucumber_publish_quiet secret_info['cucumber_publish_quiet']
    cucumber_publish_token secret_info['cucumber_publish_token']
  end
end

action_class do
  def load_dependencies
    extend Context::CommandHelper
    extend Context::DeployHelpers::DeployerHelper
    extend Context::DeployHelpers::GitHelper
    extend Context::DeployHelpers::RubyHelper
    extend Context::DeployHelpers::ContextHelper
    extend Context::DeployHelpers::CookbookHelper
    extend Context::DeployHelpers::HabitatHelper
    extend Context::Studio::Base
    extend Context::Studio::Default
    extend Context::Steps::Deploy
  end

  def secret_info
    get_secret(new_resource.owner, new_resource.home, new_resource.context_databag)
  end

  def get_secret(owner, home, context_databag)
    case ChefVault::Item.data_bag_item_type(context_databag, owner)
    when :normal
      data_bag_item(context_databag, owner).to_h
    when :encrypted
      data_bag_item(context_databag, owner).to_h
    when :vault
      ChefVault::Item.load(context_databag, owner).to_h
    end
  end

  def set_secret(owner, home, group, secret_key)
    converge_by("Setting secret config for #{owner} in #{home}") do
      directory ::File.join(home, '.chef') do
        owner owner
        group group
        mode '0700'
        action :create
      end
    
      file '/tmp/kitchen/encrypted_data_bag_secret' do
        content secret_key
        owner owner
        group group
        mode '0666'
        action :create
      end
    
      file ::File.join(home, '.chef/secret') do
        content secret_key
        owner owner
        group group
        mode '0600'
        action :create
      end
    end
  end
end ## end action_class
