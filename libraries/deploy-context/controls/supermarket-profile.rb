# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

require_relative '../../../../libraries/deploy-context'

include_controls "supermarket-profile" do
  extend Context::InspecHelpers::DeployProcess

  17.times do |control_number|
    skip_control get_control_name('os', control_number)
  end

  10.times do |control_number|
    skip_control get_control_name('package', control_number)
  end

  35.times do |control_number|
    skip_control get_control_name('sysctl', control_number)
  end
end
