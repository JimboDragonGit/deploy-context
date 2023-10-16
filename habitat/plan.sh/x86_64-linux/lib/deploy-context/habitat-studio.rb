require_relative 'cookbook-studio'

module Context
  class ContextHabitatStudio < DefaultStudio
    banner "knife context habitat studio"

    deps do
      Knife::DefaultKnifeContext.load_deps
    end

    def run
      if name_args.count > 2
        context_log "name_args = #{name_args[2...]}"
        habitat(self, %w(studio) + name_args[2...])
      end
    end
    
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
