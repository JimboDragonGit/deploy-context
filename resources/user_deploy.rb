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
  set_git(new_resource.owner, new_resource.home, new_resource.group, new_resource.email, new_resource.full_name)
  set_ssh_user(new_resource.owner, new_resource.home, new_resource.group, new_resource.ssh_private_key, new_resource.ssh_public_key)
  set_chef_user(new_resource.owner, new_resource.home, new_resource.group, new_resource.client_name, new_resource.chef_server_url, new_resource.client_key)
  set_gem_user(new_resource.owner, new_resource.home, new_resource.group, new_resource.gem_api)
end

action :planning do
  action_initialisation
end

action :execution do
  action_planning
end

action :closure do
  action_execution
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

  def set_git(owner, home, group, email, full_name)
    converge_by("Setting git config for #{owner} in #{home}") do
      template ::File.join(home, '.gitconfig') do
        source 'gitconfig.erb'
        owner owner
        group group
        mode '0600'
        action :create
        variables email: email,
        full_name: full_name
      end
    end
  end

  def set_chef_user(owner, home, group, client_name, chef_server_url, raw_client_key)
    converge_by("Setting Chef config for #{owner} in #{home}") do
      directory ::File.join(home, '.chef') do
        owner owner
        group group
        mode '0600'
        action :create
      end
      
      template ::File.join(home, '.chef/credentials') do
        source 'chef_credentials.erb'
        owner owner
        group group
        mode '0600'
        action :create
        variables client_name: client_name,
        client_key: ::File.join(home, '.chef/client_key.pem'),
        chef_server_url: chef_server_url
      end
      
      file ::File.join(home, '.chef/client_key.pem') do
        user owner
        group group
        mode '0600'
        content raw_client_key
      end
    end
  end

  def set_gem_user(owner, home, group, gemapi)
    converge_by("Setting gem config for #{owner} in #{home}") do
      local_gem_folder = ::File.join(home, '.local/share/gem')
      directory local_gem_folder do
        owner owner
        group group
        mode '0600'
        action :create
        recursive true
      end
      template ::File.join(local_gem_folder, 'credentials') do
        source 'gem_credentials.erb'
        owner owner
        group group
        mode '0600'
        action :create
        variables gemapi: gemapi
      end
    end
  end

  def set_ssh_user(owner, home, group, ssh_private_key, ssh_public_key)
    converge_by("Setting SSH config for #{owner} in #{home}") do
      ssh_config = <<EOM
Host github.com
  HostName github.com
  VerifyHostKeyDNS=yes
  StrictHostKeyChecking=no
EOM

      file ::File.join(home, '.ssh/id_rsa') do
        user owner
        group group
        mode '0600'
        content ssh_private_key + "\n"
      end
      
      file ::File.join(home, '.ssh/id_rsa.pub') do
        user owner
        group group
        mode '0644'
        content ssh_public_key
      end
      
      file ::File.join(home, '.ssh/config') do
        user owner
        group group
        mode '0644'
        content ssh_config
      end

      ssh_known_hosts_entry 'github.com' do
        owner owner
        group group
      end

      # ssh_authorized_keys "for remote access" do
      #   options { 'cert-authority' => nil, :command => '/usr/bin/startup' }
      #   user new_resource.owner
      #   key 
      #   type 'ssh-rsa'
      #   comment 'gdidy@coolman.com'
      # end
    end
  end
end ## end action_class
