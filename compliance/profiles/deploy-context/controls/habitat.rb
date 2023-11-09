# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

require_relative '../../../../libraries/deploy-context'

extend Context::InspecHelpers::DeployProcess

control 'public-habitat-01' do
  impact 0.7
  title 'Habitat inspection for deploy-context'
  desc 'Check for require public habitat'
  
  describe habitat_services do
    its('count') { should cmp 2 }
    its('names') { should include 'httpd' }
    its('names') { should include 'memcached' }
  end
end
