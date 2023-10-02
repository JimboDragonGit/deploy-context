
require 'fileutils'
require 'git-version-bump'

require_relative 'deploy-context/deploy'
require_relative 'deploy-context/deploy/git'
require_relative 'deploy-context/deploy/ruby'
require_relative 'deploy-context/deploy/cucumber'

module Context
  class DeployContext < Deploy
    include DeployHelper
    include GitDeployerHelper
    include RubyDeployerHelper
    include CucumberDeployerHelper

    def initialize(deploycontext_folder)
      super('deploy-context', deploycontext_folder)
    end

    def cycle
      clean
      patch_bump
      build
      commit
      release
      install
      if test_context_successful?
        minor_bump
      else
        puts "newer version not installed for #{context_name} and version #{GVB.version}"
        exit 1
      end
    end

    def test_context_successful?
      case `chef gem list deploy-context --local -i --version #{GVB.version}`
      when 'true'
        true
      when 'false'
        puts "Test context has failed"
        false
      end
    end

    def build
      git_build(self)
      check_folder get_context_folder(self, 'build')
      check_folder get_context_folder(self, 'contexts')
      cucumber_build(self)
      ruby_build(self)
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

    def patch_reset
      git ['tag', "v#{GVB.major_version}.#{GVB.minor_version + 1}"]
      git_commit(self)
      git_bump(self, 'patch')
    end

    def minor_bump
      git_bump(self, 'minor')
    end

    def major_bump
      git_bump(self, 'major')
    end
  end
end
