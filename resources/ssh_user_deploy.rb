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

resource_name :ssh_user_deploy
provides :ssh_user_deploy

property :owner, String, name_property: true
property :home, String
property :group, String
property :github_ssh_private_key, String
property :github_ssh_public_key, String

default_action :setup

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :setup do
  set_ssh_user(new_resource.owner, new_resource.home, new_resource.group, new_resource.github_ssh_private_key, new_resource.github_ssh_public_key)
end

action_class do
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
