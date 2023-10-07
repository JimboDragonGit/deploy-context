module Context
  module Studio
    module Base
      def help
        show_help(self)
      end

      def test
        log "\nExecute tests\n"
        log "\n\nTest result: #{test_context_successful?}\n"
      end
    
      def version
        # do_prepare unless defined?(GitVersionBump)
        # log "Getting version info for #{context_folder} and version should be #{GitVersionBump.version(true)}"
        if defined?(GitVersionBump)
          Gem::Version.new(GitVersionBump.version(true))
        else
          cookbook_version(self)
        end
      end

      def test_context_successful?
        log "Check if #{context_name} is install #{version}"
        
        if cookbook_test_successful?(self) && cucumber_test_successful?(self) && gem_installed?(self, context_name, version)
          log "Test context #{context_name} was successfully perform on version #{version}"
          true
        else
          log "Test context #{context_name} has failed to perform #{version}"
          false
        end
      end

      # def cycle
      #   ruby_cycle(self)
      # end

      # def build
      #   ruby_build(self)
      #   cookbook_build(self)
      #   build_habitat(self)
      # end

      # def commit
      #   cookbook_install(self)
      #   git_commit(self)
      # end

      # def push
      #   commit
      #   git_release(self)
      # end

      # def release
      #   log "\n\nRelease #{context_name} at version #{version}"
      #   cookbook_push(self)
      #   ruby_release(self)
      #   git_release(self)
      #   start_habitat_job(self)
      # end

      # def install
      #   ruby_install(self)
      # end

      # def clean
      #   clean_folder(self, 'contexts')
      #   ruby_clean(self)
      #   cookbook_clean(self)
      # end

      # def patch_bump
      #   GitVersionBump.tag_version("#{GitVersionBump.major_version(true)}.#{GitVersionBump.minor_version(true)}.#{GitVersionBump.patch_version(true) + 1}")
      #   show_new_version('Patch')
      # end

      # def minor_bump
      #   GitVersionBump.tag_version("#{GitVersionBump.major_version(true)}.#{GitVersionBump.minor_version(true) + 1}.0")
      #   show_new_version('Minor')
      # end

      # def major_bump
      #   GitVersionBump.tag_version("#{GitVersionBump.major_version(true) + 1}.0.0")
      #   show_new_version('Major')
      # end

      # def wait_until_release_available
      #   wait_until_release_available unless is_present_publicly?
      # end

      def load_dependencies
        require 'simplecov_setup'
        require 'git-version-bump'
        require 'cucumber'
        require 'cucumber/cli/main'
        require 'cucumber/rspec/disable_option_parser'
      end

      # def test
      #   log "\nExecute tests\n"
      #   log "\n\nTest result: #{test_context_successful?}\n"
      # end
    end
  end
end


          # case action
          # when 'cycle'
          #   context.log "\nExecute only the cycle once\n"
          #   context.cycle
          #   true
          # when 'agent'
          #   context.log "\nAlways in execution\n"
          #   while true do
          #     context.cycle
          #   end
          #   true
          # when 'commit'
          #   context.log "\nBump minor version\n"
          #   context.commit
          #   true
          # when 'push'
          #   context.log "\nBump minor version\n"
          #   context.push
          #   true
          # when 'bump'
          #   context.log "\nBump minor version\n"
          #   context.patch_bump
          #   true
          # when 'release'
          #   context.log "\nBump major version\n"
          #   context.minor_bump
          #   true
          # when 'upgrade'
          #   context.log "\nBump major version\n"
          #   context.major_bump
          #   true
          # when 'test'
          #   context.log "\nExecute tests\n"
          #   context.test_context_successful?
          # when 'reset'
          #   context.log "\nReset versionning\n"
          #   system('rake')
          #   # context.cucumber_test(deployer)
          #   true
          # when 'help'
          #   context.show_help(context)
          #   true
          # else
          #   context.error_log context.context_name, "Unknown setting #{action}"
          #   show_help(context)
          #   false
          # end