module Context
  module DeployHelpers
    module ContextHelper
      def present_localy?
        Dir.exist?(context_folder)
      end

      def shorten_version(context)
        context.version.canonical_segments[0..2].join('.')
      end

      def actual_working_directory?
        Dir.pwd == context_folder
      end
  
      def move_folder(folder)
        @context_folder = folder.include?(context_name) ? folder : File.join(folder, context_name)
      end
  
      def check_folder(folder)
        FileUtils.mkdir_p(context_folder) unless present_localy?
      end
  
      def version
        git_build(self)
        log "Getting version info for #{context_folder} and version should be #{GitVersionBump.version(true)}"
        Gem::Version.new(GitVersionBump.version(true))
      end
  
      def cycle
        ruby_cycle(self)
      end
  
      def test_context_successful?
        log "Check if #{context_name} is install #{version}"
        if gem_installed?(self)
          log "Test context #{context_name} was successfully install on version #{version}"
          true
        else
          log "Test context #{context_name} has failed to install #{version}"
          false
        end
        cookbook_test(self)
      end
  
      def build
        ruby_build(self)
        cookbook_build(self)
        check_folder get_context_file(self, 'contexts')
      end
  
      def commit
        git_commit(self)
        cookbook_install(self)
      end
  
      def release
        log "\n\nRelease #{context_name} at version #{version}"
        cookbook_push(self)
        ruby_release(self)
        git_release(self)
      end
  
      def install
        ruby_install(self)
      end
  
      def clean
        clean_folder(self, 'contexts')
        ruby_clean(self)
        cookbook_clean(self)
      end
  
      def show_new_version(level)
        log "#{level} bump #{context_name} at newer version #{version}"
      end
  
      def patch_bump
        GitVersionBump.tag_version("#{GitVersionBump.major_version(true)}.#{GitVersionBump.minor_version(true)}.#{GitVersionBump.patch_version(true) + 1}")
        show_new_version('Patch')
      end
  
      def minor_bump
        GitVersionBump.tag_version("#{GitVersionBump.major_version(true)}.#{GitVersionBump.minor_version(true) + 1}.0")
        show_new_version('Minor')
      end
  
      def major_bump
        GitVersionBump.tag_version("#{GitVersionBump.major_version(true) + 1}.0.0")
        show_new_version('Major')
      end
  
      def wait_until_release_available
        wait_until_release_available unless is_present_publicly?
      end
  
      def is_present_publicly?
        ruby_check_if_available_public(self)
      end
  
      def new_update_available?
        git_update_available?(self)
      end
  
      def ready_for_major_update?
        false
      end
    end
  end
end