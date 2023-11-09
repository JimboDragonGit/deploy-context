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

resource_name :circleci_user_deploy
provides :circleci_user_deploy

property :owner, String, name_property: true
property :home, String
property :group, String
property :circleci_token, String
property :circleci_api_token, String
property :circleci_org_optin, String

default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  set_circleci_user(new_resource.owner,
    new_resource.home,
    new_resource.group,
    new_resource.circleci_token,
    new_resource.circleci_api_token,
    new_resource.circleci_org_optin
  )
end

action_class do
  def set_circleci_user(owner, home, group, circleci_token, circleci_api_token, circleci_org_optin)
    converge_by("Setting circleci config for #{owner} in #{home}") do
      template '/etc/profile.d/circleci.sh' do
        source 'profile.sh.erb'
        owner owner
        group group
        mode '0755'
        action :create
        variables deploy_config: {
          circleci_token: circleci_token,
          circleci_api_token: circleci_api_token,
          circleci_org_optin: circleci_org_optin,
        }
      end
    end
  end
end ## end action_class
