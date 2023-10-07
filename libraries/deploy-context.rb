require_relative 'context-manager'

module Context
  class DeployContext < Manager
    def self.deployer(origin_folder = ENV.key?('DEPLOYCONTEXTFOLDER') ? ENV['DEPLOYCONTEXTFOLDER'] : Dir.pwd)
      Studio::Deployer.set(DeployContext.new(origin_folder))
      Studio::Deployer
    end

    def initialize(deploycontext_folder)
      super('jimbodragon', 'deploy-context', deploycontext_folder)
      @rubystudio = RubyStudio.new(organisation_name, context_name, deploycontext_folder)

      abort("No context_name :(") if context_name.nil? || context_name.empty?
    end
  end
end
