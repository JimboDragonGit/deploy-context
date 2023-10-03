module Context
  module GitDeployerHelper
    def git_build(context)
      Dir.chdir File.dirname(context.context_folder)
      puts "Building ruby from folder #{context.context_folder}"
      if ::Dir.exist?(context.context_folder)
        git_pull(context)
      else
        git ["clone git@github.com:JimboDragonGit/#{context.context_name}.git"] unless ::Dir.exist?(context.context_folder)
      end
    end

    def git_pull(context)
      Dir.chdir context.context_folder
      git ['pull']
    end

    def git_commit(context)
      Dir.chdir context.context_folder
      git ['add .']
      git ["commit -m 'Create #{context.context_name} automatic commit'"]
    end

    def git_release(context)
      Dir.chdir context.context_folder
      git ['push', '--follow-tags']
    end

    def git_bump(context, level)
      Dir.chdir context.context_folder
      git ['version-bump', level]
    end

    def patch_reset(context)
      git_bump(context, 'minor')
      git_commit(context)
    end

    def git_update_available?(context)
      git_build(context)
      # git ['log', "v#{context.version}"]
      git ['ls-remote origin', "v#{context.version}"]
    end
  end
end