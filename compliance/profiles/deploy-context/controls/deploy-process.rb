# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

control 'deployment-process-01' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all git roles in the correct order'

  describe command('knife deploy context cucumber git') do
    its('exit_status') { should eq 0 }
  end
end

control 'deployment-process-02' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all knife roles in the correct order'

  describe command('knife deploy context cucumber knife') do
    its('exit_status') { should eq 0 }
  end
end

control 'deployment-process-03' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute kitchen planning role'

  describe command('knife deploy context cucumber kitchen planning') do
    its('exit_status') { should eq 0 }
  end
end

control 'deployment-process-04' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute kitchen execution role'

  describe command('knife deploy context cucumber kitchen execution') do
    its('exit_status') { should eq 0 }
  end
end

control 'deployment-process-05' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all habitat roles in the correct order'

  describe command('knife deploy context cucumber habitat') do
    its('exit_status') { should eq 0 }
  end
end

control 'deployment-process-06' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all rake roles in the correct order'

  describe command('knife deploy context cucumber rake') do
    its('exit_status') { should eq 0 }
  end
end

control 'deployment-process-07' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all roles in the correct order dor'

  describe command('knife deploy context cucumber supermarket') do
    its('exit_status') { should eq 0 }
  end
end

control 'deployment-process-08' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all roles in the correct order dor'

  describe command('knife deploy context cucumber install') do
    its('exit_status') { should eq 0 }
  end
end

control 'deployment-process-09' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all roles in the correct order dor'

  describe command('knife deploy context cucumber compliance'), :skip do
    its('exit_status') { should eq 0 }
  end
end

control 'deployment-process-10' do
  impact 0.7
  title 'Deployment process for deploy-context Control'
  desc 'Execute all roles in the correct order dor'

  describe command('knife deploy context cucumber git') do
    its('exit_status') { should eq 0 }
  end
end
