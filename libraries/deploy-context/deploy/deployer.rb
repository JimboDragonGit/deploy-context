module Context
  module DeployHelpers
    module DeployerHelper
      def get_context_file(context, file)
        File.join(context.context_folder, file)
      end

      def build_folder(context)
        context.get_context_file(context, 'build')
      end
    
      def contexts_container(context)
        context.get_context_file(context, 'contexts')
      end

      def show_help(context)
        help_message = <<MESSAGE_END
Use not option or the option 'cycle' to cycle through the deployer once
Use the option 'agent' to made a continual loop of the cycle
Use the option 'bump' to bump the patch version
Use the option 'release' to bump the minor version
Use the option 'upgrade' to bump the major version
Use the option 'test' to test the context
Use the option 'reset' to execute the local cycle once
Use the option 'help' to show this message
MESSAGE_END
        context.error_log(context, help_message)
      end

      def execute_action(context, action = 'once')
        state_action = if action.nil?
          context.cycle
          false
        else
          case action
          when 'cycle'
            context.log "\nExecute only once\n"
            context.cycle
            true
          when 'agent'
            context.log "\nAlways in execution\n"
            while true do
              context.cycle
            end
            true
          when 'bump'
            context.log "\nBump minor version\n"
            context.patch_bump
            true
          when 'release'
            context.log "\nBump major version\n"
            context.minor_bump
            true
          when 'upgrade'
            context.log "\nBump major version\n"
            context.major_bump
            true
          when 'test'
            context.log "\nExecute tests\n"
            context.test_context_successful?
          when 'reset'
            context.log "\nReset versionning\n"
            system('rake')
            # context.cucumber_test(deployer)
            true
          when 'help'
            context.show_help(context)
            true
          else
            context.error_log context.context_name, "Unknown setting #{action}"
            false
          end
        end
        context.commit
        if state_action
          context.log "Action #{action} executed correctly in context #{context}"
        else
          context.error_log(context.context_name, "Failed to execute action #{action} in context #{context}")
        end
      end
    end
  end
end
