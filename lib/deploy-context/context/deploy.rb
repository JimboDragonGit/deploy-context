module Context
  module DeployHelper
    def build_folder
      'build'
    end
  
    def contexts_container
      File.join(build_folder, 'contexts')
    end
    
    def chef_exec(commands)
      system("chef exec #{commands.join(' ')}")
    end
    
    def git(commands)
      chef_exec(['git'] + commands)
    end
    
    def gem(commands)
      chef_exec(['gem'] + commands)
    end

    def context_dir(context)
      File.join(contexts_container, context.context_name)
    end
  end
end