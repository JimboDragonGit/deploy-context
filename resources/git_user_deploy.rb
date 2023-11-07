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

resource_name :git_user_deploy
provides :git_user_deploy

property :owner, String, name_property: true
property :home, String
property :group, String
property :email, String
property :fullname, String

default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  set_git(new_resource.owner, new_resource.home, new_resource.group, new_resource.email, new_resource.fullname)
end

action_class do
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
end ## end action_class
