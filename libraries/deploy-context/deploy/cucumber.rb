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
        # context.chef_exec(context,['cucumber'] + commands)

        context.existing_cucumber_runtime = cucumber_runtime(context, commands)
        # The dup is to keep ARGV intact, so that tools like ruby-debug can respawn.
        cucumber_runtime(context, commands).run!
      end

      def cucumber_test(context)
        context.git_build(context)
        context.log "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.cucumber(context)
      end
    end
  end
end
