module Context
  module DeployHelpers
    module CucumberHelper
      def cucumber_configuration(context, commands)
        context.existing_cucumber_configuration = Cucumber::Cli::Main.new(commands.dup).configuration unless context.existing_cucumber_configuration
        context.existing_cucumber_configuration
      end

      def cucumber_runtime(context, commands)
        return Cucumber::Runtime.new(context.cucumber_configuration(context, commands)) unless context.existing_cucumber_runtime

        context.existing_cucumber_runtime.configure(context.cucumber_configuration(context, commands))
        context.existing_cucumber_runtime
      end

      def cucumber(context, commands = [])
        # begin
        #   require 'cucumber'
        #   context.existing_cucumber_runtime = context.cucumber_runtime(context, commands)
        #   context.cucumber_runtime(context, commands).run!
        # rescue Exception => e
        #   context.warning_context_log context.context_name, "Cucumber library not available", "Unable to use internal cucumber, using external application instead for command #{commands}"
        #   context.execute_command(%w(chef exec cucumber) + commands)
        # end
        # # context.bundle_exec(context,['cucumber'] + commands)
        context.execute_command(%w(chef exec cucumber) + commands)
      end

      def cucumber_test(context)
        context.git_build(context)
        context.debug_context_log context.context_name, "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.cucumber(context)
      end

      def cucumber_test_successful?(context)
        result = cucumber_test(context)
        context.debug_context_log context.context_name, "\n\nCucumber test result: #{result}"
        result
      end
    end
  end
end
