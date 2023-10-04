module Context
  module DeployHelpers
    module GitHelper
      def git_build(context)
        if context.present_localy?
          Dir.chdir(context.context_folder)
          context.git_pull(context)
        else
          local_dir = File.join(Dir.pwd, context.context_name)
          context.git context, ["clone git@github.com:JimboDragonGit/#{context.context_name}.git"] unless ::Dir.exist?(local_dir)
          context.move_folder(local_dir)
        end
      end

      def git_pull(context)
        context.git_build(context) unless context.actual_working_directory?
        context.git context, ['pull']
      end

      def git_commit(context)
        context.git_build(context)
        context.git context, ['add .']
        context.git context, ["commit -m 'Create #{context.context_name} automatic commit'"]
      end

      def git_release(context)
        context.git_build(context)
        context.git context, ['push', '--follow-tags']
      end

      def git_bump(context, level)
        context.git_build(context)
        context.git context, ['version-bump', level]
        context.git_commit(context)
      end

      def patch_reset(context)
        context.git_build(context)
        context.git_bump(context, 'minor')
      end

      def git_update_available?(context)
        context.git_build(context)
        # context.git ['log', "v#{context.version}"]
        context.git context, ['ls-remote origin', "v#{context.version}"]
      end

      def git_dirty_state?(context)
        context.git_build(context)
        # context.git ['log', "v#{context.version}"]
        context.get_data(["git status --porcelain"]).split('\n').count > 0
      end
    end
  end
end