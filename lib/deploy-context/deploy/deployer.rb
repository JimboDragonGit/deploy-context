module Context
  module DeployHelpers
    module DeployerHelper
      def get_context_folder(context, folder)
        File.join(context.context_folder, folder)
      end

      def build_folder(context)
        context.get_context_folder(context, 'build')
      end
    
      def contexts_container(context)
        context.get_context_folder(context, 'contexts')
      end

      def execute_action(context, action)
        state_action = if action.nil?
          context.cycle
          false
        else
          case action
          when 'once'
            context.log "\nExecute only once\n"
            context.cycle
            true
          when 'always'
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
          else
            context.log "Unknown setting #{action}"
            false
          end
        end
        context.commit
        if state_action
          context.log "Action #{action} executed correctly in context #{context}"
        else
          context.abort("Failed to execute action #{action} in context #{context}")
        end
      end
    end
  end
end
