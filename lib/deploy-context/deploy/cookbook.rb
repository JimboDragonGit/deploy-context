module Context
  module DeployHelpers
    module CookbookHelper
      def chef(context, commands)
        context.execute_command(%w(chef) + commands)
      end

      def chef_exec(context, commands)
        context.chef(context, %w(exec) + commands)
      end

      def chef_generate(context, commands)
        context.chef(context, %w(generate) + commands)
      end

      def generate_cookbook(context, cookbook)
        context.chef(context, %w(cookbook) + cookbook)
      end

      def kitchen(context, commands = %w(test))
        context.chef_exec(context, %w(kitchen) + commands)
      end

      def cookbook_build(context)
        context.git_build(context)
        context.log "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        Dir.chdir File.dirname(context.context_folder)
        context.generate_cookbook(context, [context.context_name])
        Dir.chdir context.context_folder
      end

      def cookbook_test(context)
        context.cookbook_build(context)
        context.log "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.kitchen(context)
      end
    end
  end
end
