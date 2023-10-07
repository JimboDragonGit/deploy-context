require_relative 'cucumber-studio'

module Context
  class CookbookStudio < CucumberStudio
    def initialize(organisation_name, context_name, deploycontext_folder)
      super(organisation_name, context_name, deploycontext_folder)
    end
    
    # 4
    def do_clean
      super
      delete_file_only_if_exist(get_context_file(self, 'Policyfile.lock.json'))
      true
    end
    
    # 7
    def do_build
      cookbook_build(self)
      true
    end
    
    # 8
    def do_check
      cookbook_test(self)
      true
    end
    
    # 9
    def do_install
      cookbook_install(self)
      true
    end

    # 10
    def do_strip
      super
      cookbook_push(self)
      true
    end

    # 11
    def do_end
      super
      cookbook_result = do_mix_cookbook
      log "Mix the cookbook #{context_name}: #{cookbook_result.class}"
      supermarket_push(self)
      true
    end
  end
end
