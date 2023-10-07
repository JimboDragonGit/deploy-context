require_relative 'helpers/command'
require_relative 'helpers/rake_tasks'

require_relative 'deploy/context'
require_relative 'deploy/cookbook'
require_relative 'deploy/cucumber'
require_relative 'deploy/deployer'
require_relative 'deploy/git'
require 'rubygems'
require 'bundler'
require 'fileutils'
require 'json'

require_relative 'deploy/context'
require_relative 'deploy/cookbook'
require_relative 'deploy/cucumber'
require_relative 'deploy/deployer'
require_relative 'deploy/git'
require_relative 'deploy/habitat'
require_relative 'deploy/ruby'
require_relative 'deploy/vagrant'

require_relative 'studio/default'
require_relative 'studio/deployer'

require_relative 'helpers/command'
require_relative 'helpers/rake_tasks'

require_relative 'steps/deploy'

module Context
  class DefaultStudio
    include CommandHelper
    include DeployHelpers::DeployerHelper
    include DeployHelpers::GitHelper
    include DeployHelpers::RubyHelper
    include DeployHelpers::ContextHelper
    include DeployHelpers::CookbookHelper
    include DeployHelpers::HabitatHelper
    include Studio::Base
    include Studio::Default
    include Steps::Deploy

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

    # 4
    def do_clean
      delete_file_only_if_exist(get_context_file(self, 'respond.txt'))
      true
    end
    
    # 7
    def do_strip
      git_build(self)
    end
    
    # 7
    def do_end
      git_commit(self)
    end
  end
end
