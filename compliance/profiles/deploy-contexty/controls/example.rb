# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

control 'example_control' do
  impact 0.7
  title 'Example Control'
  desc 'This is an example control.  Replace with real test content.'

  describe user('root') do
    it { should exist }
  end
end
