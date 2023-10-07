require_relative 'ruby-studio'

module Context
  class CucumberStudio < RubyStudio
    def initialize(organisation_name, context_name, deploycontext_folder)
      super(organisation_name, context_name, deploycontext_folder)
    end
  end
end
