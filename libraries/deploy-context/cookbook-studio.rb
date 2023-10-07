require_relative 'cucumber-studio'

module Context
  class CookbookStudio < CucumberStudio
    def initialize(organisation_name, context_name, deploycontext_folder)
      super(organisation_name, context_name, deploycontext_folder)
    end
    
    # 7
    def do_build
      super
      cookbook_build(self)
      true
    end
    
    # 8
    def do_check
      super
      cookbook_test(self)
      true
    end
    
    # 9
    def do_install
      super
      cookbook_install(self)
      true
    end

    def do_strip
      super
      cookbook_push(self)
      true
    end

    def do_end
      super
      cookbook_result = do_mix_cookbook
      log "Mix the cookbook #{context_name}: #{cookbook_result.class}"
      true
    end
  end
end
