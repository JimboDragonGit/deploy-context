require_relative 'helpers/command'
require_relative 'deploy/deployer'
require_relative 'deploy/git'


module Context
  class Deploy
    include CommandHelper
    include DeployHelpers::DeployerHelper
    include DeployHelpers::GitHelper

    attr_reader :context_name
    attr_reader :context_folder

    def initialize(context_name, deploycontext_folder)
      @context_name = context_name
      @context_folder = move_folder(deploycontext_folder)
    end

    def present_localy?
      Dir.exist?(context_folder)
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
      puts "Getting version info for #{context_folder} and version should be #{GitVersionBump.version(true)}"
      Gem::Version.new(GitVersionBump.version(true))
    end

    def cycle
      ruby_cycle(self)
    end

    def test_context_successful?
      puts "Check if #{context_name} is install #{version}"
      if gem_installed?(self)
        puts "Test context #{context_name} was successfully install on version #{version}"
        true
      else
        abort "Test context #{context_name} has failed to install #{version}"
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
      GitVersionBump.tag_version("#{GitVersionBump.major_version(true)}.#{GitVersionBump.minor_version(true)}.#{GitVersionBump.patch_version(true) + 1}")
    end

    def minor_bump
      GitVersionBump.tag_version("#{GitVersionBump.major_version(true)}.#{GitVersionBump.minor_version(true) + 1}.0")
    end

    def major_bump
      GitVersionBump.tag_version("#{GitVersionBump.major_version(true) + 1}.0.0")
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
