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

resource_name :docker_user_deploy
provides :docker_user_deploy

property :owner, String, name_property: true
property :home, String
property :group, String
property :dockerhub_user, String
property :dockerhub_password, String

default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  set_docker_user(new_resource.owner, new_resource.home, new_resource.group, new_resource.dockerhub_user, new_resource.dockerhub_password)
end

action_class do
  def set_docker_user(owner, home, group, dockerhub_user, dockerhub_password)
    converge_by("Setting docker config for #{owner} in #{home}") do
      template '/etc/profile.d/docker.sh' do
        source 'profile.sh.erb'
        owner owner
        group group
        mode '0600'
        action :create
        variables deploy_config: {
          dockerhub_user: dockerhub_user,
          dockerhub_password: dockerhub_password,
          docker_user: dockerhub_user,
          docker_pass: dockerhub_password,
        }
      end
    end
  end
end ## end action_class
