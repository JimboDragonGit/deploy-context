# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

title 'deploy-context cucumber status control'

control 'deploy-context-01' do
  impact 0.7
  title 'deploy-context Control'
  desc 'This is the deploy-context control.'

  describe user('root') do
    it { should exist }
  end
end
