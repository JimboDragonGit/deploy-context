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
property :ssh_private_key, String
property :ssh_public_key, String
property :client_name, String
property :client_key, String
property :chef_server_url, String
property :gem_api, String
property :email, String
property :full_name, String

default_action :execution

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :initialisation do
  load_dependencies
  set_git
  set_ssh_user
  set_chef_user
  set_gem_user
end

action :planning do
end

action :execution do
end

action :closure do
end

action_class do
  def load_dependencies
    extend Context::CommandHelper
    extend Context::DeployHelpers::DeployerHelper
    extend Context::DeployHelpers::GitHelper
    extend Context::DeployHelpers::RubyHelper
    extend Context::DeployHelpers::ContextHelper
    extend Context::DeployHelpers::CookbookHelper
    extend Context::DeployHelpers::RecipeHelper
    extend Context::DeployHelpers::HabitatHelper
    extend Context::Studio::Base
    extend Context::Studio::Default
    extend Context::Steps::Deploy
  end

  def set_git
    template ::File.join(new_resource.home, '.gitconfig') do
      source 'gitconfig'
      owner new_resource.owner
      group new_resource.owner
      mode '0755'
      action :create
      variables email: new_resource.email,
      full_name: new_ressource.full_name
    end
  end

  def set_chef_user
    directory ::File.join(new_resource.home, '.chef') do
      owner new_resource.owner
      group new_resource.owner
      mode '0755'
      action :create
    end
    
    template ::File.join(new_resource.home, '.chef/credentials') do
      source 'chef_credentials'
      owner new_resource.owner
      group new_resource.owner
      mode '0755'
      action :create
      variables client_name: new_resource.client_name,
      client_key: ::File.join(new_resource.home, '.chef/client_key.pem'),
      chef_server_url: new_resource.chef_server_url
    end
    
    file ::File.join(new_resource.home, '.chef/client_key.pem') do
      user new_resource.owner
      mode '0600'
      content new_resource.client_key
    end
  end

  def set_gem_user
    template ::File.join(new_resource.home, '.local/share/gem/credentials') do
      source 'gem_credentials'
      owner new_resource.owner
      group new_resource.owner
      mode '0755'
      action :create
      variables gemapi: new_resource.gemapi
    end
  end

  def set_ssh_user
    ssh_known_hosts "github.com" do
      hashed true
      user new_resource.owner
    end
    
    ssh_config "github.com" do
      options 'User' => 'git',
        'VerifyHostKeyDNS' => 'yes',
        'StrictHostKeyChecking' => 'no'
      user new_resource.owner
    end
    
    file ::File.join(new_resource.owner, '.ssh/id_rsa') do
      user new_resource.owner
      mode '0600'
      content new_resource.ssh_private_key
    end
    
    file ::File.join(new_resource.owner, '.ssh/id_rsa.pub') do
      user new_resource.owner
      mode '0600'
      content new_resource.ssh_public_key
    end

    # ssh_authorized_keys "for remote access" do
    #   options { 'cert-authority' => nil, :command => '/usr/bin/startup' }
    #   user new_resource.owner
    #   key 
    #   type 'ssh-rsa'
    #   comment 'gdidy@coolman.com'
    # end
    
  end
end ## end action_class
