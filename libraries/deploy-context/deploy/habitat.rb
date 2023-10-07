module Context
  module DeployHelpers
    module HabitatHelper
      def habitat_organisation_name(context)
        'jimbodragon'
      end

      def habitat(context, commands = [])
        context.bundle_exec(context, ['hab'] + commands)
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
        context.debug_log("Starting an Habitat job #{context.get_shell_data(['hab', 'bldr', 'job', 'start', 'habitat/plan.sh'])}")
        true
      end

      def promote_habitat(context, job_id = File.read(get_context_file(context, 'HAB_BUILD_ID')), channel = 'unstable')
        if ! context.already_promoted?(context) && context.latest_hab_build_succeed?(context)
          context.set_hab_build_id(context, context.hab_latest_build_status(context).id)
          context.habitat(context, ['bldr', 'job', 'promote', job_id, channel]) 
        else
          context.error_log(context.context_name, "Promote context #{context.context_name} impossible")
        end
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

      def hab_latest_build_status(context)
        build_result = OpenStruct.new
        build_result.command = [
          'hab bldr job status',
          '--showjobs -l 25 --origin',
          context.organisation_name,
          "| grep '#{context.context_name}' | head -n 1",
        ]
        # build_result.result_file = File.join(context.temp_dir, 'raw_return.txt')
        # context.debug_log "Getting data from command #{build_result.command} and result at #{build_result.result_file}"
        # File.write(build_result.result_file, context.get_shell_data(build_result.command))
        # build_result.build_id_raw = "#{File.read(build_result.result_file)}"
        # context.debug_log "And raw return from file is #{build_result.build_id_raw}"
        # build_result.return_arr = build_result.build_id_raw.split("\n")
        # context.debug_log "And return array is #{build_result.return_arr}"
        # build_result.return_str = build_result.return_arr[3]
        # context.debug_log "And return string is #{build_result.return_str}"
        # build_result.result_arr = build_result.return_str.split(' ')
        # context.debug_log "And result array is #{build_result.result_arr}"

        result_array = context.get_shell_data(build_result.command).split("\n")[0].split(' ')
        build_result.id = result_array[1]
        build_result.status = result_array[2]
        build_result
      end

      def hab_build_id(context)
        File.read(context.get_context_file(context, 'HAB_BUILD_ID'))
      end

      def already_promoted?(context)
        context.hab_latest_build_status(context).id == context.hab_build_id(context)
      end

      def latest_hab_build_succeed?(context)
        context.hab_latest_build_status(context).status == 'Complete'
      end

      def set_hab_build_id(context)
        context.git_build(context)
        # , "#{organisation_name}/#{context_name}"
        running_build_id = 
        context.debug_log "Setting the build ID from #{context.hab_build_id(context)} to #{running_build_id}"

        File.write(context.get_context_file(context, 'HAB_BUILD_ID'), context.hab_build_id(context))
      end
    end
  end
end
