# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/
module Context
  module ControlsHelpers
    module CommandHelper
      def control_deployer_command
        %w(kitchen knife habitat inspec compliance rake install supermarket ).each do |app_name|
          initial_counter = 0
          control_app(app_name, initial_counter, 'knife')
          control_app(app_name, initial_counter, 'cucumber')
          control_app(app_name, initial_counter, 'inspec')
        end
      end
    end
  end
end
