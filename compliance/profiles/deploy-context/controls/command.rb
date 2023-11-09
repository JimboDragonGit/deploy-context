# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

require_relative '../../../../libraries/deploy-context'

extend Context::InspecHelpers::DeployProcess

title 'deploy-context cucumber status control'

%w(kitchen knife habitat inspec compliance rake install supermarket ).each do |app_name|
  initial_counter = 0
  control_app(app_name, initial_counter, 'knife')
  control_app(app_name, initial_counter, 'cucumber')
  control_app(app_name, initial_counter, 'inspec')
end
