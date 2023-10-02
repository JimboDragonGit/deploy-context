module Context
  module DeployHelper
    def get_context_folder(context, folder)
      File.join(context.context_folder, folder)
    end

    def build_folder(context)
      get_context_folder(context, 'build')
    end
  
    def contexts_container(context)
      get_context_folder(context, 'contexts')
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
    
    def rake(commands)
      chef_exec(['rake'] + commands)
    end
    
    def cucumber(commands = [])
      chef_exec(['cucumber'] + commands)
    end
  end
end