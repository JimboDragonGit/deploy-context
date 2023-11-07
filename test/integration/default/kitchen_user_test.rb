# Chef InSpec test for recipe deploy-context::kitchen_user

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# require 'deploy-context'

# extend Context::CucumberSuiteHelper

def log_object(object_name, object)
  warning_context_log object_name, "\n#{object_name}.class = #{object.class}\n"
  debug_context_log object_name, "#{object_name}.methods = #{object.methods}\n"
  context_log "#{object_name} = #{object}\n"
end

def show_object(object_name, object)
  puts "#{object_name} = #{object}\n"
end

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end

# log_object('integration', self)
# log_object('platform', platform)
# show_object('profile_name', profile_name)
# show_object('home_dir', home_dir)
show_object('pwd', Dir.pwd)
# show_object('user', ENV['user'])
# show_object('instance_name', instance_name)

hab_env_vars = %w(
  HAB_AUTH_TOKEN
  HAB_CACHE_KEY_PATH
  HAB_DEPOT_URL
  HAB_ORG
  HAB_ORIGIN
  HAB_ORIGIN_KEYS
  HAB_RING
  HAB_RING_KEY
  HAB_STUDIOS_HOME
  HAB_STUDIO_ROOT
  HAB_USER
  DO_CHECK
)

hab_env_vars.each do |e|
  describe os_env(e) do
    its('content') { should eq nil }
  end
end

gems_list = %w(
  cucumber
  knife-ec2
  kitchen-vagrant
  kitchen-dokken
  kitchen-ec2
  ruby-shadow
  deploy-context
)

gems_list.each do |e|
  describe gem(e, :chef) do
    it { should be_installed }
  end
end

describe directory(::File.join('/home/vagrant', 'deploy-context')) do
  its('type') { should cmp 'directory' }
  it { should be_directory }
  its('owner') { should cmp 'vagrant' }
  # context.log_object('describe', self)
  # context.show_object('description', description)
  # context.log_object('context', context)
  # context.show_object('example', example)
end

# describe habitat_package(origin: 'jimbodragon', name: 'deploy-context') do
#   it             { should exist }
#   its('version') { should eq ::File.read('VERSION')}
#   its('release') { should eq '20190307151146'}
# end
