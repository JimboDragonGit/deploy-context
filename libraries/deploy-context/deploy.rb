

require 'simplecov_setup'
require 'cucumber/rspec/disable_option_parser'
require 'cucumber/cli/main'

require 'rubygems'
require 'fileutils'
require 'git-version-bump'

require_relative 'helpers/command'
require_relative 'deploy/deployer'
require_relative 'deploy/git'
require_relative 'deploy/context'
require_relative 'deploy/habitat'


module Context
  class Deploy
    include CommandHelper
    include DeployHelpers::DeployerHelper
    include DeployHelpers::GitHelper
    include DeployHelpers::ContextHelper
    include DeployHelpers::HabitatHelper

    attr_reader :context_name
    attr_reader :context_folder

    attr_accessor :existing_cucumber_runtime
    attr_accessor :existing_cucumber_configuration

    attr_reader :organisation_name


    def initialize(organisation_name, context_name, deploycontext_folder)
      @context_name = context_name
      @context_folder = move_folder(deploycontext_folder)
      @organisation_name = organisation_name
    end
  end
end
