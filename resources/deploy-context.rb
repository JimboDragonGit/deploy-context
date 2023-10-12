# name 'Resource file for chef_workstation_initialize'
# maintainer 'Jimbo Dragon'
# maintainer_email 'jimbo_dragon@hotmail.com'
# license 'MIT'
# description 'Resource file for chef_workstation_initialize'
# version '0.1.0'
# chef_version '>= 16.6.14'
# issues_url 'https://github.com/jimbodragon/chef_workstation_initialize/issues'
# source_url 'https://github.com/jimbodragon/chef_workstation_initialize'

# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/

resource_name :deploycontext
provides :deploycontext

default_action :execution

# use_inline_resources
unified_mode true

load_current_value do |current_resource|
end

action :initialisation do
  load_dependencies
end

action :planning do
end

action :execution do
  execute 'chef exec cucumber'
  
  # cucumber self
end

action :closure do
end

action_class do
  def load_dependencies
    extend Context::CommandHelper
    extend Context::DeployHelpers::DeployerHelper
    extend Context::DeployHelpers::GitHelper
    extend Context::DeployHelpers::RubyHelper
    extend Context::DeployHelpers::ContextHelper
    extend Context::DeployHelpers::CookbookHelper
    extend Context::DeployHelpers::RecipeHelper
    extend Context::DeployHelpers::HabitatHelper
    extend Context::Studio::Base
    extend Context::Studio::Default
    extend Context::Steps::Deploy
  end
  
  def context_suite
    if @context_suite.nil?
      @context_suite = OpenStruct.new
      @context_suite.status_file = 'deploy-status.json'
      # @context_suite.suite_kitchen = "patatae"
      @context_suite.status = :initialisation
    end
    @context_suite
  end
  
  def context_name
    context_suite.context_name
  end
  
  def context_folder
    context_suite.context_folder
  end
  
  def existing_cucumber_runtime
    context_suite.existing_cucumber_runtime
  end
  
  def existing_cucumber_configuration
    context_suite.existing_cucumber_configuration
  end
  
  def organisation_name
    context_suite.organisation_name
  end
end ## end action_class
