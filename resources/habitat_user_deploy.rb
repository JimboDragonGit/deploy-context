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

resource_name :habitat_user_deploy
provides :habitat_user_deploy

property :owner, String, name_property: true
property :home, String
property :group, String
property :hab_auth_token, String
property :hab_origin, String
property :hab_license, String
property :kitchen_workstation, String

default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  set_habitat_user(new_resource.owner, new_resource.home, new_resource.group, new_resource.hab_auth_token, new_resource.hab_origin, new_resource.hab_license, new_resource.kitchen_workstation)
  execute 'accept habitat license' do
    command 'hab license accept'
    action :run
  end
  execute 'setup habitat cli' do
    command 'hab cli setup'
    action :run
  end
end

action_class do
  def set_habitat_user(owner, home, group, hab_auth_token, hab_origin, hab_license, kitchen_workstation)
    converge_by("Setting Chef Habitat config for #{owner} in #{home}") do
      template '/etc/profile.d/habitat.sh' do
        source 'profile.sh.erb'
        owner owner
        group group
        mode '0755'
        action :create
        variables deploy_config: {
          hab_auth_token: hab_auth_token,
          hab_origin: hab_origin,
          hab_license: hab_license,
          kitchen_workstation: kitchen_workstation
        }
      end
    end
  end
end ## end action_class
