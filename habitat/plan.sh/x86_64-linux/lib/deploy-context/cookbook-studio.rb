require_relative 'ruby-studio'

module Context
  class ContextCookbookStudio < DefaultStudio
    banner "knife context cookbook studio"

    deps do
      Knife::DefaultKnifeContext.load_deps
    end

    def run
      case name_args[0]
      when 'converge'
        kitchen(self, name_args)
      when 'verify'
        kitchen(self, name_args)
      when 'destroy'
        kitchen(self, name_args)
      end
    end
    
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
