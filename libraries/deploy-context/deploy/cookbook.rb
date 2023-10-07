module Context
  module DeployHelpers
    module CookbookHelper
      def chef(context, commands)
        context.execute_command(%w(chef) + commands)
      end

      def knife(context, commands)
        context.execute_command(%w(knife) + commands)
      end

      def chef_exec(context, commands)
        context.chef(context, %w(exec) + commands)
      end

      def cookbook_path(context)
        File.dirname(context.context_folder)
      end

      def chef_generate(context, commands)
        context.log("\n\nGenerating Chef components with command #{commands}")
        context.chef(context, %w(generate) + commands)
      end

      def generate_cookbook(context, cookbookname)
        context.chef_generate(context, %w(cookbook) + cookbookname)
      end

      def kitchen(context, commands = %w(test))
        context.chef_exec(context, %w(kitchen) + commands)
      end

      def cookbook_build(context)
        context.log("\n\nBuilding cookbook #{context.context_name}\n\n")
        context.git_build(context)
        Dir.chdir File.dirname(context.context_folder)
        context.generate_cookbook(context, [context.context_name]) unless Dir.exist?(context.get_context_file(context, 'recipes'))
        context.set_cookbook_version(context)
        Dir.chdir context.context_folder
      end

      def cookbook_test(context)
        cookbook_build(context)
        context.log "\n\nExecuting kitchen in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.kitchen(context)
      end

      def cookbook_test_successful?(context)
        result = cookbook_test(context)
        context.log "\n\nCookbook test result: #{result}"
        result
      end

      def cookbook_install(context)
        cookbook_build(context)
        context.log "\n\nInstalling cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.chef(context, %w(install))
      end

      def cookbook_push(context)
        cookbook_build(context)
        context.log "\n\nPushing cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.chef(context, ['push', context.context_name, 'Policyfile.lock.json'])
        context.knife context, ['cookbook', 'upload', context.context_name, '--cookbook-path', context.cookbook_path(context)]
      end

      def supermarket_push(context)
        cookbook_build(context)
        context.log "\n\nPushing cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.chef(context, ['supermarket', 'share', context.context_name, '--cookbook-path', context.cookbook_path(context)])
      end

      def clean_file(context, file)
        clean_file = context.get_context_file(context, file)
        context.log "Clean file #{clean_file}"
        FileUtils.rm(clean_file) if File.exist?(clean_file)
      end

      def cookbook_clean(context)
        context.cookbook_build(context)
        context.log "\n\nCleaningcookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.clean_file(context, 'Policyfile.lock.json')
      end

      def mix_run_list(context, run_list)
        context.chef_exec(context, ['chef-client', '-z', '-o', run_list])
      end

      def set_cookbook_version(context)
        context.git_build(context)
        File.write(context.get_context_file(context, 'VERSION'), context.shorten_version(context).strip)
        File.write(context.get_context_file(context, 'DATE'), GVB.date)
      end
    end
  end
end
