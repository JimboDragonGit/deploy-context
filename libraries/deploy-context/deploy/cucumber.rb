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
        context.existing_cucumber_runtime = cucumber_runtime(context, commands)
        cucumber_runtime(context, commands).run!
        # context.chef_exec(context,['cucumber'] + commands)
      end

      def cucumber_test(context)
        context.git_build(context)
        context.debug_log "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.cucumber(context)
      end

      def cucumber_test_successful?(context)
        result = cucumber_test(context)
        context.debug_log "\n\nCucumber test result: #{result}"
        result
      end
    end
  end
end
