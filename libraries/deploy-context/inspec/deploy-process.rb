module Context
  module InspecHelpers
    module DeployProcess
      def get_control_name(control_name, control_number)
        [control_name, control_number.to_s.rjust(2,'0')].join('-')
      end
      
      def control_app(app_name, counter, command_to_test)
        control [app_name, counter].join('-') do
          impact 0.7
          title "#{app_name} Control with knife"
          desc "This is the #{app_name} control for deploy-context."
      
          describe command(command_to_test).exist? do
            it { should eq true }
          end
        end
        counter += 1
      end

      def control_cucumber_command(command_to_test, app_name, counter = 0)
        control [app_name, counter].join('-') do
          impact 0.7
          title "Deployment process for #{app_name} in deploy-context Control"
          desc "Execute all #{app_name} roles in the correct order"
      
          describe command(command_to_test) do
            its('exit_status') { should eq 0 }
          end
        end
        counter += 1
      end

      def control_env_var(variable_name, counter = 0)
        initial_counter = 0
        control_env_var_value variable_name, counter, ENV[variable_name.upcase]
        control_env_var_value variable_name, counter, input(variable_name)
      end
      
      def control_env_var_value(variable_name, counter, value_to_test)
        control [variable_name, counter].join('-') do
          impact 0.7
          title "#{variable_name} environment variable with inspec"
          desc "This is the #{variable_name} control for deploy-context environment variable."
      
          describe value_to_test do
            extend Context::DeployKnifeConstant
            # it_behaves_like variable_name
            # it_should_behaves_like variable_name
            it do
              should_not be_empty
              should_not include 'ENV['
            end
          end
        end
        counter += 1
      end
    end
  end
end
