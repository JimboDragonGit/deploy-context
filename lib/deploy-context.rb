
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
      ruby_cycle(self)
    end

    def test_context_successful?
      puts "Check if deploy-context is install #{GVB.major_version}.#{GVB.minor_version}"
      deploy_context_installed = `chef exec gem list deploy-context --local -i --version #{GVB.major_version}.#{GVB.minor_version}`.strip
      puts "deploy_context_installed = #{deploy_context_installed}"
      case deploy_context_installed
      when 'true'
        cucumber_build(self)
      when 'false'
        puts "Test context has failed"
        false
      else
        puts "Test context is unknown with #{deploy_context_installed}"
        false
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
  end
end
