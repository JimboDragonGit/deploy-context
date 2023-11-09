# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

control 'deployment-process-01' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all roles in the correct order dor'

  describe command('knife deploy context cucumber git') do
    it { should exist }
    its('exit_status') { should eq 0 }
  end

  describe command('knife deploy context cucumber knife') do
    it { should exist }
    its('exit_status') { should eq 0 }
  end

  describe command('knife deploy context cucumber kitchen planning') do
    it { should exist }
    its('exit_status') { should eq 0 }
  end

  describe command('knife deploy context cucumber kitchen execution') do
    it { should exist }
    its('exit_status') { should eq 0 }
  end

  describe command('knife deploy context cucumber habitat') do
    it { should exist }
    its('exit_status') { should eq 0 }
  end

  describe command('knife deploy context cucumber rake') do
    it { should exist }
    its('exit_status') { should eq 0 }
  end

  describe command('knife deploy context cucumber supermarket') do
    it { should exist }
    its('exit_status') { should eq 0 }
  end

  describe command('knife deploy context cucumber install') do
    it { should exist }
    its('exit_status') { should eq 0 }
  end
end
