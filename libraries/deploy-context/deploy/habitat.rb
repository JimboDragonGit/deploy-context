module Context
  module DeployHelpers
    module HabitatHelper
      def habitat_organisation_name(context)
        'jimbodragon'
      end

      def habitat(context, commands = [])
        context.chef_exec(context, ['hab'] + commands)
      end

      def intialize_habitat(context, commands = [])
        context.habitat(context, ['plan', 'init'] + commands)
      end

      def render_habitat(context, commands = [])
        context.habitat(context, ['plan', 'render'] + commands)
      end

      def build_habitat(context, commands = [])
        context.habitat(context, ['studio', 'build', 'habitat/plan.sh'] + commands)
      end

      def start_habitat_job(context, commands = [])
        context.habitat(context, ['bldr', 'job', 'start', 'habitat/plan.sh'] + commands)
      end

      def promote_habitat(context, job_id, channel)
        context.habitat(context, ['bldr', 'job', 'promote', job_id, channel])
      end

      def load_habitat(context, commands = [])
        supervisor_command = %w(hab svc load) + ["#{habitat_organisation_name(context)}/#{context.context_name}", '--strategy at-once']
        if context.is_admin?
          context.habitat(context, supervisor_command + commands)
        else
          context.execute_command(%w(sudo hab) + supervisor_command + commands) unless Gem.win_platform?
        end
      end

      def run_habitat_supervisor(context, commands = [])
        supervisor_command = %w(sup run)
        if context.is_admin?
          context.habitat(context, supervisor_command + commands)
        else
          context.execute_command(%w(sudo hab) + supervisor_command + commands) unless Gem.win_platform?
        end
      end

      def install_habitat_supervisor(context, commands = [])
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
