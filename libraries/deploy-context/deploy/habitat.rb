module Context
  module DeployHelpers
    module HabitatHelper
      def habitat(context, commands = [])
        context.chef_exec(context, ['hab'] + commands)
      end

      def build_habitat(context, commands = [])
        context.habitat(context, ['build'] + commands)
      end

      def run_habitat_supervisor(context, commands = [])
        supervisor_command = %w(sup run)
        if context.is_admin?
          context.habitat(context, supervisor_command + commands)
        else
          context.execute_command(%w(sudo hab) + supervisor_command + commands) unless Gem.win_platform?
        end
      end
    end
  end
end
