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

resource_name :gem_user_deploy
provides :gem_user_deploy

property :owner, String, name_property: true
property :home, String
property :group, String
property :rubygems_api_key, String

default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  set_gem_user(new_resource.owner, new_resource.home, new_resource.group, new_resource.rubygems_api_key)
end

action_class do
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
end ## end action_class
