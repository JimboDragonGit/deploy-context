require_relative 'default-studio'

module Context
  class RubyStudio < DefaultStudio
    def initialize(organisation_name, context_name, deploycontext_folder)
      super(organisation_name, context_name, deploycontext_folder)
    end

    # 2
    def do_download
      super
      do_clean
      system('bundle install')
      true
    end
    
    # 4
    def do_clean
      super
      delete_file_only_if_exist(get_context_file(self, 'Gemfile.lock'))
      true
    end
  end
end
