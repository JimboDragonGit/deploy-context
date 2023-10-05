require_relative 'helpers/command'
require_relative 'deploy/deployer'
require_relative 'deploy/git'
require_relative 'deploy/context'


module Context
  class Deploy
    include CommandHelper
    include DeployHelpers::DeployerHelper
    include DeployHelpers::GitHelper
    include DeployHelpers::ContextHelper

    attr_reader :context_name
    attr_reader :context_folder

    def initialize(context_name, deploycontext_folder)
      @context_name = context_name
      @context_folder = move_folder(deploycontext_folder)
    end
  end
end
