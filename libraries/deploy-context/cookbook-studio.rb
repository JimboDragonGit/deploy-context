require_relative 'ruby-studio'

module Context
  class CookbookStudio < DefaultStudio
    # def initialize(context_organisation_name, deployer_context_name, deploycontext_folder, default_ruby_studio = nil)
    #   super(context_organisation_name, deployer_context_name, deploycontext_folder, default_ruby_studio)
    # end
    
    # 4
    def do_clean
      super
      delete_file_only_if_exist(get_context_file(self, 'Policyfile.lock.json'))
      kitchen(%w(destroy))
      true
    end
    
    # 6
    def do_prepare
      cookbook_build(self)
      true
    end
    
    # 7
    def do_build
      cookbook_install(self)
      true
    end
    
    # 8
    def do_check
      cookbook_test(self)
      true
    end
    
    # 9
    def do_install
      knife_push(self)
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
      supermarket_push(self)
      true
    end

    def studio_available?
      is_binary_available?('kitchen') && is_binary_available?('knife') && super
    end
  end
end
