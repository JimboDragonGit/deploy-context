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

resource_name :cucumber_user_deploy
provides :cucumber_user_deploy

property :owner, String, name_property: true
property :home, String
property :group, String
property :cucumber_publish_enabled, String
property :cucumber_publish_quiet, String
property :cucumber_publish_token, String

default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  set_cucumber(
    new_resource.owner,
    new_resource.home,
    new_resource.group,
    new_resource.cucumber_publish_enabled,
    new_resource.cucumber_publish_quiet,
    new_resource.cucumber_publish_token
  )
end

action_class do
  def set_cucumber(owner, home, group, cucumber_publish_enabled, cucumber_publish_quiet, cucumber_publish_token)
    converge_by("Setting cucumber config for #{owner} in #{home}") do
      template '/etc/profile.d/cucumber.sh' do
        source 'profile.sh.erb'
        owner owner
        group group
        mode '0755'
        action :create
        variables deploy_config: {
          cucumber_publish_enabled: cucumber_publish_enabled,
          cucumber_publish_quiet: cucumber_publish_quiet,
          cucumber_publish_token: cucumber_publish_token
        }
      end
    end
  end
end ## end action_class
