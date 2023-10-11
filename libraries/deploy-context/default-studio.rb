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

require_relative 'knife/default_knife_context'

# require_relative 'ruby-studio'
# require_relative 'cookbook-studio'
# require_relative 'habitat-studio'
# require_relative 'cucumber-studio'

module Context
  class DefaultStudio < Knife::DefaultKnifeContext
    include CommandHelper
    include DeployHelpers::DeployerHelper
    include DeployHelpers::GitHelper
    include DeployHelpers::RubyHelper
    include DeployHelpers::ContextHelper
    include DeployHelpers::CookbookHelper
    include DeployHelpers::RecipeHelper
    include DeployHelpers::HabitatHelper
    include Studio::Base
    include Studio::Default
    include Steps::Deploy

    # attr_reader :context_name
    # attr_reader :context_folder

    # attr_accessor :existing_cucumber_runtime
    # attr_accessor :existing_cucumber_configuration

    # attr_reader :organisation_name

    attr_reader :ruby_studio
    attr_reader :cookbook_studio
    attr_reader :habitat_studio
    attr_reader :cucumber_studio

    # attr_reader :context_state

    banner 'knife default studio'

    option :context_name,
      :short => '-N',
      :long => '--context-name',
      :description => "Name of the context"

    option :context_folder,
      :short => '-P',
      :long => '--context-path',
      :description => "Path of the context"

    option :organisation_name,
      :short => '-O',
      :long => '--organisation-name',
      :description => "Organisation name of the context"

    option :ruby_studio,
      :short => '-B',
      :long => '--ruby-studio',
      :description => "Path of the ruby studio"

    option :cookbook_studio,
      :short => '-B',
      :long => '--cookbook-studio',
      :description => "Path of the cookbook studio"

    option :habitat_studio,
      :short => '-H',
      :long => '--habitat-studio',
      :description => "Path of the habitat studio"

    option :cucumber_studio,
      :short => '-C',
      :long => '--cucumber-studio',
      :description => "Path of the cucumber studio"

    option :context_state,
      :short => '-S',
      :long => '--context-state',
      :description => "Set the value of the state before run"

    # def initialize(argv)
    #   @context_name = deployer_context_name
    #   @context_folder = deploycontext_folder # move_folder(deploycontext_folder)
    #   @organisation_name = context_organisation_name
    #   @ruby_studio = default_ruby_studio
    # end

    # def initialize(context_organisation_name, deployer_context_name, deploycontext_folder, default_ruby_studio = nil)
    #   @context_name = deployer_context_name
    #   @context_folder = deploycontext_folder # move_folder(deploycontext_folder)
    #   @organisation_name = context_organisation_name
    #   @ruby_studio = default_ruby_studio
    # end

		def context_name
      config[:context_name]
		end

		def context_folder
      config[:context_folder]
		end

		def existing_cucumber_runtime
      config[:existing_cucumber_runtime]
		end

		def existing_cucumber_configuration
      config[:existing_cucumber_configuration]
		end

		def organisation_name
      config[:organisation_name]
		end

		def ruby_studio
      @ruby_studio = RubyStudio.new if @ruby_studio.nil? 
      @ruby_studio
		end

		def cookbook_studio
      @cookbook_studio = CookbookStudio.new if @cookbook_studio.nil? 
      @cookbook_studio
		end

		def habitat_studio
      @habitat_studio = HabitatStudio.new if @habitat_studio.nil? 
      @habitat_studio
		end

		def cucumber_studio
      @cucumber_studio = CucumberStudio.new if @cucumber_studio.nil? 
      @cucumber_studio
		end

    def studio_order
      [ruby_studio, cookbook_studio, habitat_studio, cucumber_studio]
    end

    def do_begin
      # @ruby_studio = Context::RubyStudio.new(organisation_name, context_name, context_folder) if ruby_studio.nil?

      # @cookbook_studio = Context::CookbookStudio.new(organisation_name, context_name, context_folder, ruby_studio) if cookbook_studio.nil?

      # @habitat_studio = Context::HabitatStudio.new(organisation_name, context_name, context_folder, ruby_studio) if habitat_studio.nil?

      # @cucumber_studio = Context::CucumberStudio.new(organisation_name, context_name, context_folder, ruby_studio) if cucumber_studio.nil?

      studio_order
    end
    
    # 2
    def do_download
      git_build(self)
    end
    
    # 3
    def do_verify
      git_build(self)
    end

    # 4
    def do_clean
      delete_file_only_if_exist(get_context_file(self, 'respond.txt'))
      true
    end
    
    # 10
    def do_strip
      git_build(self)
    end
    
    # 11
    def do_end
      git_commit(self)
    end

    def studio_available?
      is_binary_available?('git')
    end
  end
end
