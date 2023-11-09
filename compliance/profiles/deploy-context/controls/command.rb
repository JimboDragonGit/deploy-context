
require_relative '../../../../libraries/deploy-context'

extend Context::CucumberSuiteHelper
extend Context::DeployKnifeConstant

title 'deploy-context cucumber command control'


%w(kitchen knife habitat inspec compliance rake install supermarket ).each do |app_name|
  command_to_test = (%w(knife deploy context cucumber) + [app_name])
  control [app_name, '01'].join('-') do
    impact 0.7
    title "#{app_name} Control with knife"
    desc "This is the #{app_name} control for deploy-context."

    describe command('knife').exist? do
      it { should eq true }
    end
  end

  control [app_name, '02'].join('-') do
    impact 0.7
    title "#{app_name} Control with cucumber"
    desc "This is the #{app_name} control for deploy-context."

    describe command('cucumber').exist? do
      it { should eq true }
    end
  end

  control [app_name, '03'].join('-') do
    impact 0.7
    title "#{app_name} Control with inspec"
    desc "This is the #{app_name} control for deploy-context."

    describe command('inspec').exist? do
      it { should eq true }
    end
  end
end
