require_relative 'cookbook-studio'

module Context
  class HabitatStudio < CookbookStudio
    def initialize(organisation_name, context_name, deploycontext_folder)
      super(organisation_name, context_name, deploycontext_folder)
    end
    
    def do_clean
      super
      delete_file_only_if_exist(get_context_file(self, 'respond.txt'))
      true
    end
    
    def do_install
      super
      gem self, ['install', context_name]
      build_habitat(self)
      true
    end

    # 9
    def do_strip
      super
      Dir.chdir context_folder
      start_habitat_job(self)
      true
    end
    
    # 11
    def do_end
      super
      promote_habitat(self)
    end
  end
end
