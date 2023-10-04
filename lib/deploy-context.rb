
require 'fileutils'
require 'git-version-bump'

require_relative 'deploy-context/deploy'
require_relative 'deploy-context/deploy/ruby'
require_relative 'deploy-context/deploy/cucumber'

module Context
  class DeployContext < Deploy
    include DeployHelpers::RubyHelper
    include DeployHelpers::CucumberHelper

    def self.deployer
      @deployer = Context::DeployContext.new(Dir.pwd) if @deployer.nil?
      @deployer
    end

    def initialize(deploycontext_folder)
      super('deploy-context', deploycontext_folder)
    end
  end
end
