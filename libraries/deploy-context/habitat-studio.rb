require_relative 'cookbook-studio'

module Context
  class HabitatStudio < DefaultStudio
    # def initialize(context_organisation_name, deployer_context_name, deploycontext_folder, default_ruby_studio = nil)
    #   super(context_organisation_name, deployer_context_name, deploycontext_folder, default_ruby_studio)
    # end
    
    def do_clean
      super
      delete_file_only_if_exist(get_context_file(self, 'respond.txt'))
      delete_folder_only_if_exist(get_context_file(self, 'results/logs'))
      true
    end
    
    def do_install
      super
      bundle_gem self, ['install', context_name]
      build_habitat(self)
      true
    end

    # 10
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

    def studio_available?
      is_binary_available?('hab') && super
    end
  end
end
