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
        context.error_log(context.context_name, help_message)
      end

      def execute_action(context, action)
        state_action = if action.nil?
          show_help(context)
          false
        else
          if context.respond_to?(action)
            context.log("\n\nStarting Action '#{action}'")
            context.send(action)
          else
            context.error_log(context, "Action '#{action}' is unavailable")
            false
          end
        end
        # context.commit
        if state_action
          context.log "\n\nAction #{action} executed correctly in context #{context}"
          state_action.perform unless state_action.kind_of?(TrueClass)
        else
          context.error_log(context.context_name, "Failed to execute action #{action} in context #{context.context_name}")
        end
      end
    end
  end
end
