module Context
  module DeployHelpers
    module CookbookHelper
      def chef(context, commands)
        context.debug_log "Executing chef command #{commands}"
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
        context.debug_log("\n\nGenerating Chef components with command #{commands}")
        context.chef(context, %w(generate) + commands)
      end

      def generate_cookbook(context, cookbookname)
        context.chef_generate(context, %w(cookbook) + cookbookname)
      end

      def kitchen(context, commands = %w(test))
        context.chef_exec(context, %w(kitchen) + commands)
      end

      def cookbook_build(context)
        context.debug_log("\n\nBuilding cookbook #{context.context_name}\n\n")
        context.git_build(context)
        Dir.chdir File.dirname(context.context_folder)
        context.generate_cookbook(context, [context.context_name]) unless Dir.exist?(context.get_context_file(context, 'recipes'))
        context.set_cookbook_version(context)
        Dir.chdir context.context_folder
      end

      def cookbook_test(context)
        cookbook_build(context)
        context.debug_log "\n\nExecuting kitchen in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.kitchen(context)
      end

      def cookbook_test_successful?(context)
        result = cookbook_test(context)
        context.debug_log "\n\nCookbook test result: #{result}"
        result
      end

      def cookbook_install(context)
        cookbook_build(context)
        context.debug_log "\n\nInstalling cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.chef(context, %w(install))
      end

      def cookbook_push(context)
        cookbook_build(context)
        context.debug_log "\n\nPushing cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.chef(context, ['push', context.context_name, 'Policyfile.lock.json'])
        context.knife context, ['cookbook', 'upload', context.context_name, '--cookbook-path', context.cookbook_path(context)]
      end

      def supermarket_push(context)
        cookbook_build(context)
        context.debug_log "\n\nPushing cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.chef(context, ['supermarket', 'share', context.context_name, '--cookbook-path', context.cookbook_path(context)])
      end

      def clean_file(context, file)
        clean_file = context.get_context_file(context, file)
        context.debug_log "Clean file #{clean_file}"
        FileUtils.rm(clean_file) if File.exist?(clean_file)
      end

      def cookbook_clean(context)
        context.cookbook_build(context)
        context.debug_log "\n\nCleaningcookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.clean_file(context, 'Policyfile.lock.json')
      end

      def mix_run_list(context, run_list)
        context.execute_command(['chef-client', '-o', run_list])
      end

      def cookbook_version(context)
        context_version_file = context.get_context_file(context, 'VERSION')
        context.log "context_version_file = #{context_version_file}"
        context_version_file = if File.exist? context_version_file
          context_version_file
        else
          File.join(__dir__, '../../../VERSION')
        end
        File.read(context_version_file)
      end

      def set_cookbook_version(context)
        context.git_build(context)
        File.write(context.get_context_file(context, 'VERSION'), context.shorten_version(context).strip)
        File.write(context.get_context_file(context, 'DATE'), GVB.date)
      end
    end
  end
end
