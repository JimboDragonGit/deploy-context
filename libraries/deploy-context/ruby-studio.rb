require_relative 'default-studio'

module Context
  class ContextRubyStudio < DefaultStudio
    banner "knife context ruby studio"

    deps do
      Knife::DefaultKnifeContext.load_deps
    end

    option :omg,
      :short => '-O',
      :long => '--omg',
      :description => "I'm so excited! 9"

    def run
      if config[:omg]
        puts "OMG HELLO WORLD!!!9!!99"
      else
        puts "I am just a fucking example. 9"
      end
    end
    
    # 2
    def do_download
      super
      system('bundle install')
      true
    end
    
    # 2
    # def do_verify
    #   super
    #   cucumber(self)
    #   true
    # end
    
    # 4
    def do_clean
      super
      delete_file_only_if_exist(get_context_file(self, 'Gemfile.lock'))
      true
    end
    
    # 9
    def do_end
      super
      ruby_release(self)
      true
    end

    def studio_present?
      execute_command('which ruby') || super
    end
  end
end
