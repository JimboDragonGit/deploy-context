module Context
  module GitDeployerHelper
    def git_build(context)
      if context.present_localy?
        Dir.chdir(context.context_folder)
        git_pull(context)
      else
        local_dir = File.join(Dir.pwd, context.context_name)
        git ["clone git@github.com:JimboDragonGit/#{context.context_name}.git"] unless ::Dir.exist?(local_dir)
        context.move_folder(local_dir)
      end
    end

    def git_pull(context)
      git_build(context) unless context.actual_working_directory?
      git ['pull']
    end

    def git_commit(context)
      git_build(context)
      git ['add .']
      git ["commit -m 'Create #{context.context_name} automatic commit'"]
    end

    def git_release(context)
      git_build(context)
      git ['push', '--follow-tags']
    end

    def git_bump(context, level)
      git_build(context)
      git ['version-bump', level]
      git_commit(context)
    end

    def patch_reset(context)
      git_build(context)
      git_bump(context, 'minor')
    end

    def git_update_available?(context)
      git_build(context)
      # git ['log', "v#{context.version}"]
      git ['ls-remote origin', "v#{context.version}"]
    end

    def git_dirty_state?(context)
      git_build(context)
      # git ['log', "v#{context.version}"]
      `git status --porcelain`.split('\n').count > 0
    end
  end
end