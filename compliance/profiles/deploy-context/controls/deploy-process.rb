# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

control 'deployment-process-01' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all roles in the correct order dor'

  describe command('knife deploy context cucumber git') do
    its('exit_status') { should eq 0 }
    it { should exist }
  end

  describe command('knife deploy context cucumber knife') do
    its('exit_status') { should eq 0 }
    it { should exist }
  end

  describe command('knife deploy context cucumber kitchen planning') do
    its('exit_status') { should eq 0 }
    it { should exist }
  end

  describe command('knife deploy context cucumber kitchen execution') do
    its('exit_status') { should eq 0 }
    it { should exist }
  end

  describe command('knife deploy context cucumber habitat') do
    its('exit_status') { should eq 0 }
    it { should exist }
  end

  describe command('knife deploy context cucumber rake') do
    its('exit_status') { should eq 0 }
    it { should exist }
  end

  describe command('knife deploy context cucumber supermarket') do
    its('exit_status') { should eq 0 }
    it { should exist }
  end

  describe command('knife deploy context cucumber install') do
    its('exit_status') { should eq 0 }
    it { should exist }
  end
end
