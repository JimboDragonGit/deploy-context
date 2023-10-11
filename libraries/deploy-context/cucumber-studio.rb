require_relative 'habitat-studio'

module Context
  class CucumberStudio < DefaultStudio
    # def initialize(context_organisation_name, deployer_context_name, deploycontext_folder, default_ruby_studio = nil)
    #   super(context_organisation_name, deployer_context_name, deploycontext_folder, default_ruby_studio)
    # end

    def studio_available?
      is_binary_available?('cucumber') && super
    end
  end
end
