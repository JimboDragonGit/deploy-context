# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

control 'deployment-process-01' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all roles in the correct order dor'

  describe user('root') do
    it { should exist }
  end
end
