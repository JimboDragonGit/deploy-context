module Context
  module DeployHelpers
    module RubyHelper
      def bundle(context, commands, command_type = :system)
        context.debug_log "Executing chef command #{commands}"
        context.execute_command(%w(bundle) + commands, command_type)
      end

      def bundle_exec(context, commands, command_type = :system)
        context.bundle(context, %w(exec) + commands, command_type)
      end

      def bundle_install(context, commands, command_type = :system)
        context.bundle(context, %w(install) + commands, command_type)
      end

      def bundle_gem(context, commands, command_type = :system)
        context.execute_command(%w(gem) + commands, command_type)
      end
      
      def bundle_rake(context, commands = [], command_type = :system)
        context.execute_command(%w(rake) + commands, command_type)
      end

      def ruby_build(context)
        context.git_build(context)
        context.debug_log "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created"
        check_folder get_context_file(context, 'build')
      end

      def ruby_release(context)
        context.git_build(context)
        # gem ["push #{context.context_name}-#{GVB.version}.gem"]
        # context.patch_bump if gem_installed?(context, context.context_name)
        context.bundle_rake context, ['release']
        # context.commit
      end

      def ruby_install(context)
        context.bundle_gem context, ['install', context.context_name]
      end

      def clean_folder(context, folder)
        clean_folder = context.get_context_file(context, folder)
        puts "Clean folder #{clean_folder}"
        FileUtils.remove_dir(clean_folder) if Dir.exist?(clean_folder)
      end

      def ruby_clean(context)
        clean_folder(context, 'pkg')
      end

      def ruby_remove_gem(context)
        clean_folder(context, 'pkg')
      end

      def ruby_check_if_available_public(context)
        puts "Waiting a minute before installing #{context.context_name} in folder #{context.context_folder}"
        `chef gem list #{context.context_name}`
        # sleep(60)
      end

      def gem_available?(context, gemname, compare_version = nil)
        begin
          available_version = Gem::Specification.find_by_name(gemname)
        rescue Gem::MissingSpecError => e
          context.error_log(context, "The gem '#{gemname}' is missing")
          # sleep(5)
          available_version = nil
        rescue Exception => e
          context.error_log(context, "The gem '#{gemname}' got issue with #{e}")
          sleep(5)
          available_version = nil
        end
        # context.debug_log("Compare #{context.context_name} available_version #{available_version} with #{context.version} in folder #{context.context_folder}")
        available = if compare_version.nil? || available_version.nil?
          not available_version.nil?
        else
          available_version.version == context.version
        end
        puts "available = #{available}"
        available
      end

      def gem_installed?(context, gemname, compare_version = nil)
        gem_list = context.bundle_gem(context, ['list', context.context_name, "| #{context.context_name}"], :get_data)
        # pending
      end

      def load_dependency(context, gemname, require_file)
        context.gem(context, ['install', gemname]) unless context.gem_installed?(context, gemname)
        context.debug_log("Loading file #{require_file} for gem #{gemname}")
        sleep 3
        require require_file
      end

      def load_all_dependencies(context)
        context.load_dependencies
      end

      def ruby_cycle(context)
        context.debug_log "\n\nBuilding Ruby application for #{context.context_name}"
        if context.new_update_available?
          context.debug_log "\n\nNew update available for #{context.context_name}\nCleaning the building space"
          context.clean
          # if git_dirty_state?(context)
          #   context.patch_bump
          #   context.commit
          # end
          context.debug_log "\n\nBuilding project #{context.context_name} now ..."
          context.build
          # context.commit
          context.debug_log "\n\nReleasing project #{context.context_name}"
          context.release
          context.wait_until_release_available
          context.debug_log "\n\nInstalling project #{context.context_name}"
          context.install
          if context.test_context_successful?
            context.debug_log "newer version installed successfully for #{context.context_name} on version #{context.version}"
            # context.patch_bump
            # patch_reset(context)
          else
            context.debug_log "newer version not installed for #{context.context_name} on version #{context.version}"
          end
        else
          context.debug_log "No update available"
        end
      end
    end
  end
end
