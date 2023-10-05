require_relative 'deploy-context/deploy'
require_relative 'deploy-context/deploy/ruby'
require_relative 'deploy-context/deploy/cucumber'
require_relative 'deploy-context/deploy/cookbook'

module Context
  class DeployContext < Deploy
    include DeployHelpers::RubyHelper
    include DeployHelpers::CucumberHelper
    include DeployHelpers::CookbookHelper

    def self.deployer
      @deployer = Context::DeployContext.new(Dir.pwd) if @deployer.nil?
      @deployer
    end

    def initialize(deploycontext_folder)
      super('deploy-context', deploycontext_folder)
    end
  end
end
