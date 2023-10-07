require 'rubygems'
require 'fileutils'

require_relative 'deployer'
require_relative 'base'

require_relative 'helpers/command'
require_relative 'helpers/rake_tasks'

require_relative 'deploy/deployer'
require_relative 'deploy/git'
require_relative 'deploy/context'
require_relative 'deploy/habitat'
require_relative 'deploy/plan'

require_relative 'steps/deploy'

module Context
  class Deploy
    include CommandHelper
    include DeployHelpers::DeployerHelper
    include DeployHelpers::GitHelper
    include DeployHelpers::ContextHelper
    include DeployHelpers::HabitatHelper
    include DeployHelpers::PlanHelper
    include Base

    attr_reader :context_name
    attr_reader :context_folder

    attr_accessor :existing_cucumber_runtime
    attr_accessor :existing_cucumber_configuration

    attr_reader :organisation_name


    def initialize(organisation_name, context_name, deploycontext_folder)
      @context_name = context_name
      @context_folder = deploycontext_folder # move_folder(deploycontext_folder)
      @organisation_name = organisation_name
    end
  end
end
