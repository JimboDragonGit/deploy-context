# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
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

resource_name :chef_user_deploy
provides :chef_user_deploy

property :owner, String, name_property: true
property :home, String
property :group, String
property :deploy_client_name, String
property :deploy_server_url, String
property :deploy_client_key, String

default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  Chef::Log.warn("On vas-tu lavoir ciboire")
  set_chef_user(new_resource.owner, new_resource.home, new_resource.group, new_resource.deploy_client_name, new_resource.deploy_server_url, new_resource.deploy_client_key)
end

action :accept_habitat do
  accept_license(owner, home, group, accepted_id, accepted_name, accepted_date, accepted_product_name, accepted_version, accepted_user)
end

action_class do
  def set_chef_user(owner, home, group, client_name, chef_server_url, raw_client_key)
    converge_by("Setting Chef config for #{owner} in #{home}") do
      directory ::File.join(home, '.chef/plugins') do
        owner owner
        group group
        mode '0700'
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
end ## end action_class
