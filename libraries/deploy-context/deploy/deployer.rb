module Context
  module DeployHelpers
    module DeployerHelper
      def load_public_dependencies
        require 'rubygems'
        require 'bundler'
        # require 'bundler/setup'
        # require 'bundler/installer'
        
        require 'rdoc/task'
        
        require 'git-version-bump'
        require 'git-version-bump/rake-tasks'
        
        require 'cucumber'
        require 'cucumber/rake/task'
  
        require_relative '../../deploy-context'
      end
  
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
#{
  context.actions_permitted.each do |action|
    puts "Available action '#{action}'"
  end
}
Use not option or the option 'cycle' to cycle through the deployer once
Use the option 'agent' to made a continual loop of the cycle
Use the option 'bump' to bump the patch version
Use the option 'release' to bump the minor version
Use the option 'upgrade' to bump the major version
Use the option 'test' to test the context
Use the option 'reset' to execute the local cycle once
Use the option 'help' to show this message
MESSAGE_END
        context.warning_context_log(context.context_name, help_message)
      end

      def actions_permitted?(action)
        log "Is Default action '#{action}' permitted?"
        action_is_permit = actions_permitted.include?(action)
  
        log "The answer is #{action_is_permit} through '#{actions_permitted}'"
        action_is_permit
      end

      def execute_action(context, action)
        state_action = if action.nil?
          show_help(context)
          false
        else
          if context.respond_to?(action)
            context.debug_context_log(context.context_name, "\n\nStarting Action '#{action}'")
            context.send(action)
          else
            context.error_context_log(context, "Action '#{action}' is unavailable")
            false
          end
        end
        # context.commit
        if state_action || ! state_action.kind_of?(Integer)
          context.debug_context_log context.context_name, "\n\nAction #{action} executed correctly in context #{context}.context_name"
          state_action.perform unless state_action.kind_of?(TrueClass)
        else
          context.error_context_log(context.context_name, "Failed to execute action #{action} in context #{context.context_name} resulting to a #{state_action}")
        end
      end
    end
  end
end
