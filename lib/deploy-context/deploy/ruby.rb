module Context
  module RubyDeployerHelper
    def ruby_build(context)
      git_build(context)
      Dir.chdir context.context_folder
      puts "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created"
      rake ['build']
    end

    def ruby_release(context)
      Dir.chdir context.context_folder
      # gem ["push #{context.context_name}-#{GVB.version}.gem"]
      rake ['release']
    end

    def ruby_install(context)
      Dir.chdir context.context_folder
      gem ['install', context.context_name]
    end

    def clean_folder(context, folder)
      clean_folder = get_context_folder(context, folder)
      puts "Clean folder #{clean_folder}"
      FileUtils.remove_dir(clean_folder) if Dir.exist?(clean_folder)
    end

    def ruby_clean(context)
      clean_folder(context, 'pkg')
    end

    def ruby_remove_gem(context)
      clean_folder(context, 'pkg')
    end
  end
end