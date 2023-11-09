# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

require_relative '../../../../libraries/deploy-context'

extend Context::InspecHelpers::DeployProcess

[
  'git_json',
  'knife_json',
  'planning_json',
  'kitchen_json planning',
  'kitchen_json execution',
  'habitat_json',
  'rake_json',
  'supermarket_json',
  'install_json',
  'compliance_json',
  'git_json',
].each do |command_to_perform|
  control_cucumber_command("knife deploy context cucumber #{command_to_perform}", command_to_perform)
end
