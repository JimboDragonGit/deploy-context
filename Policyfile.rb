# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'deploy-context'

# Where to find external cookbooks:
default_source :supermarket do |market|
  market.preferred_for(
    'chef-ingredient',
    "yum-epel",
    "vagrant",
    "ssh_authorized_keys",
    "docker-engine",
    "docker-ce",
    "docker",
    "apt",
    "apache2",
    "ssh_known_hosts"
  )
end

default_source :chef_server, 'https://api.chef.io/organizations/jimbodragon' do |market|
  market.preferred_for 'infra_chef', "virtualbox", 'chefserver'
end

# default_source :chef_repo, '../..' do |market|
#   market.preferred_for 'chef_infra', 'chef_workstation_initialize', 'chef-git-server', 'chefserver', 'virtualbox'
# end

# default_source :chef_repo, '../../librairies/' do |market|
#   market.preferred_for 'infraClass'
# end

# run_list: chef-client will run these recipes in the order specified.
run_list 'deploy-context::default'

# Specify a custom source for a single cookbook:
cookbook 'deploy-context', path: '.'


named_run_list :workstation, ['recipe[deploy-context::workstation]']
# named_run_list :virtualbox, ['recipe[infra_chef::virtualbox]']
# named_run_list :docker, ['recipe[infra_chef::docker]']
named_run_list :chefserver, ['recipe[chefserver]']
# named_run_list :default, ['recipe[infra_chef::workstation]', 'recipe[infra_chef::virtualbox]', 'recipe[infra_chef::docker]', 'recipe[infra_chef::chefserver]']

named_run_list :habitat, ['recipe[deploy-context::habitat]']
