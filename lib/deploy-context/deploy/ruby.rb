require 'rubygems'

module Context
  module RubyDeployerHelper
    def ruby_build(context)
      git_build(context)
      Dir.chdir context.context_folder
      puts "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created"
      check_folder get_context_folder(context, 'build')
    end

    def ruby_release(context)
      Dir.chdir context.context_folder
      # gem ["push #{context.context_name}-#{GVB.version}.gem"]
      context.patch_bump if gem_installed?(context)
      rake ['release']
    end

    def ruby_install(context)
      Dir.chdir context.context_folder
      gem ['install', context.context_name]
    end

    def clean_folder(context, folder)
      clean_folder = get_context_folder(context, folder)
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
      puts "Waiting a minute before installing"
      `chef gem list #{context.context_name}`
      # sleep(60)
    end

    def gem_installed?(context)
      installed_version = Gem::Specification.find_by_name(context.context_name).version
      puts "Compare #{context.context_name} installed_version #{installed_version} with #{context.version}"
      installed = installed_version == context.version
      puts "installed = #{installed}"
      installed
    end

    def ruby_cycle(context)
      if context.new_update_available?
        context.clean
        context.build
        context.commit
        context.release
        context.wait_until_release_available
        context.install
        if context.test_context_successful?
          puts "newer version installed successfully for #{context.context_name} on version #{context.version}"
          # context.patch_bump
          # patch_reset(context)
        else
          puts "newer version not installed for #{context.context_name} on version #{context.version}"
        end
      else
        puts "No update available"
      end
    end
  end
end
