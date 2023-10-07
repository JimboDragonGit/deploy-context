require_relative 'deploy-context/default'
require_relative 'deploy-context/deploy/ruby'
require_relative 'deploy-context/deploy/cucumber'
require_relative 'deploy-context/deploy/cookbook'

module Context
  class DeployContext < DefaultDeploy
    include DeployHelpers::RubyHelper
    include DeployHelpers::CucumberHelper
    include DeployHelpers::CookbookHelper
    include Steps::Deploy

    def self.deployer(origin_folder = ENV.key?('DEPLOYCONTEXTFOLDER') ? ENV['DEPLOYCONTEXTFOLDER'] : Dir.pwd)
      Deployer.set(DeployContext.new(origin_folder))
      Deployer
    end

    def initialize(deploycontext_folder)
      super('jimbodragon', 'deploy-context', deploycontext_folder)
    end
  end
end
