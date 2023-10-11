require_relative 'default-studio'

module Context
  class RubyStudio < DefaultStudio
    # def initialize()
    # end
    
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
