require_relative 'context/deploy'

module Context
  class Deploy
    include DeployHelper

    attr_reader :context_name
    attr_reader :context_folder

    def initialize(context_name, deploycontext_folder)
      @context_name = context_name
      @context_folder = deploycontext_folder.include?(context_name) ? deploycontext_folder : File.join(deploycontext_folder, context_name)
    end

    def present_localy?
      Dir.exist?(context_folder)
    end

    def check_folder(folder)
      FileUtils.mkdir_p(context_folder) unless present_localy?
    end

    def version
      Dir.chdir(context_folder)
      Gem::Version.new(GVB.version)
    end

    def cycle
      ruby_cycle(self)
    end

    def test_context_successful?
      puts "Check if deploy-context is install #{version}"
      if gem_installed?(self)
        puts "Test context was successfully install on version #{version}"
        true
      else
        abort "Test context has failed to install #{version}"
      end
    end

    def build
      ruby_build(self)
      check_folder get_context_folder(self, 'contexts')
    end

    def commit
      git_commit(self)
    end

    def release
      ruby_release(self)
      git_release(self)
    end

    def install
      ruby_install(self)
    end

    def clean
      clean_folder(self, 'contexts')
      ruby_clean(self)
    end

    def patch_bump
      git_bump(self, 'patch')
    end

    def minor_bump
      git_bump(self, 'minor')
    end

    def major_bump
      git_bump(self, 'major')
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
