
module Context
  module DeployHelpers
    module CookbookHelper
      def bundle_chef(context, commands, command_type = :system)
        context.debug_context_log context.context_name, "Executing chef command #{commands}"
        context.execute_command(%w(chef) + commands, command_type)
      end

      def chef_exec(context, commands, command_type = :system)
        context.bundle_chef(context, %w(exec) + commands, command_type)
      end

      def knife(context, commands, command_type = :system)
        context.chef_exec(context, %w(knife) + commands, command_type)
      end

      def kitchen(context, commands = %w(test), command_type = :system)
        context.execute_command(%w(kitchen) + commands, command_type)
      end

      def cookbook_path(context)
        File.dirname(context.context_folder)
      end

      def chef_generate(context, commands)
        context.debug_context_log(context.context_name, "\n\nGenerating Chef components with command #{commands}")
        context.bundle_chef(context, %w(generate) + commands)
      end

      def generate_cookbook(context, cookbookname)
        context.chef_generate(context, %w(cookbook) + cookbookname)
      end

      def cookbook_build(context)
        context.debug_context_log(context.context_name, "\n\nBuilding cookbook #{context.context_name}\n\n")
        context.git_build(context)

        Dir.chdir File.dirname(context.context_folder)
        # context.generate_cookbook(context, [context.context_name]) unless Dir.exist?(context.get_context_file(context, 'recipes'))
        
        Dir.chdir context.context_folder
        context.debug_context_log(context.context_name, "\n\nBuilding cookbook #{context.context_name} in path #{Dir.pwd} for folder #{context.context_folder}\n\n")
        context.set_cookbook_version(context)
      end

      def cookbook_test(context)
        context.cookbook_build(context)
        context.debug_context_log context.context_name, "\n\nExecuting kitchen in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.kitchen(context)
      end

      def cookbook_test_successful?(context)
        result = cookbook_test(context)
        context.debug_context_log context.context_name, "\n\nCookbook test result: #{result}"
        result
      end

      def cookbook_install(context)
        cookbook_build(context)
        context.debug_context_log context.context_name, "\n\nInstalling cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.bundle_chef(context, %w(install))
      end

      def knife_push(context)
        cookbook_build(context)
        context.debug_context_log context.context_name, "\n\nKnife pushing cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.knife context, ['cookbook', 'upload', context.context_name, '--cookbook-path', context.cookbook_path(context)]
      end

      def cookbook_push(context)
        cookbook_build(context)
        context.debug_context_log context.context_name, "\n\nChef pushing cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.bundle_chef(context, ['push', context.context_name, 'Policyfile.lock.json'])
      end

      def supermarket_push(context)
        cookbook_build(context)
        context.debug_context_log context.context_name, "\n\nPushing cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.bundle_chef(context, ['supermarket', 'share', context.context_name, '--cookbook-path', context.cookbook_path(context)])
      end

      def clean_file(context, file)
        clean_file = context.get_context_file(context, file)
        context.debug_context_log context.context_name, "Clean file #{clean_file}"
        FileUtils.rm(clean_file) if File.exist?(clean_file)
      end

      def cookbook_clean(context)
        context.cookbook_build(context)
        context.debug_context_log context.context_name, "\n\nCleaning cookbook in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.clean_file(context, 'Policyfile.lock.json')
        context.clean_file(context, 'Berksfile.lock')
        context.clean_file(context, 'spec/inspec.lock')
        context.clean_file(context, 'spec/unit/recipes/inspec.lock')
      end

      def mix_run_list(context, run_list)
        context.bundle_exec(context, ['chef-client', '-o', run_list])
      end

      def cookbook_version(context)
        context_version_file = context.get_context_file(context, 'VERSION')
        context_version_file = if File.exist? context_version_file
          context_version_file
        else
          File.join(__dir__, '../../../VERSION')
        end
        context.context_log "context_version_file = #{context_version_file}"
        File.read(context_version_file)
      end

      def set_cookbook_version(context)
        context.git_build(context)
        if(defined?(GVB))
          File.write(context.get_context_file(context, 'VERSION'), context.shorten_version(context).strip)
          File.write(context.get_context_file(context, 'DATE'), GVB.date)
        else
          context.warning_context_log(context.context_name, "Unable to set the cookbook version as GVB is not defined")
        end
      end
    end
  end
end
