
require 'fileutils'
require 'git-version-bump'

require_relative 'deploy-context/deploy'
require_relative 'deploy-context/deploy/ruby'
require_relative 'deploy-context/deploy/git'

module Context
  class DeployContext < Deploy
    include DeployHelper
    include GitDeployerHelper
    include RubyDeployerHelper

    attr_reader :build_folder

    def initialize(deploycontext_folder)
      @build_folder = deploycontext_folder
      super('deploy-context')
    end

    def cycle
      build
      commit
      release
      install
    end

    def build
      git_build(self)
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
  end
end
