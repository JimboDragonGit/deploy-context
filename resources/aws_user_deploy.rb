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

resource_name :aws_user_deploy
provides :aws_user_deploy

property :owner, String, name_property: true
property :home, String
property :group, String
property :aws_access_key_id, String
property :aws_secret_access_key, String

default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  set_aws(new_resource.owner, new_resource.home, new_resource.group, new_resource.aws_access_key_id, new_resource.aws_secret_access_key)
end

action_class do
  def set_aws(owner, home, group, aws_access_key_id, aws_secret_access_key)
    converge_by("Setting AWS config for #{owner} in #{home}") do
      template '/etc/profile.d/aws.sh' do
        source 'profile.sh.erb'
        owner owner
        group group
        mode '0600'
        action :create
        variables deploy_config: {
          aws_access_key_id: aws_access_key_id,
          aws_secret_access_key: aws_secret_access_key
        }
      end
    end
  end
end ## end action_class
