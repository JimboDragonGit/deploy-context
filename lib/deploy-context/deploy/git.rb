module Context
  module GitDeployerHelper
    def git_build(context)
      Dir.chdir contexts_container
      puts "Building ruby from folder #{contexts_container}"
      git ["clone git@github.com:JimboDragonGit/#{context.context_name}.git"] unless ::Dir.exist?(context.context_dir(context))
    end

    def git_commit(context)
      Dir.chdir context.context_dir(context)
      git ['add .']
      git ["commit -m 'Create #{context.context_name} automatic commit'"]
    end

    def git_release(context)
      Dir.chdir context.context_dir(context)
      git ['push', '--follow-tags']
    end
  end
end