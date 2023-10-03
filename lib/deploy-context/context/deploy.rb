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

    def execute_action(context, action)
      if action.nil?
        context.cycle
      else
        case action
        when 'once'
          puts "\nExecute only once\n"
          context.cycle
        when 'always'
          puts "\nAlways in execution\n"
          while true do
            context.cycle
          end
        when 'bump'
          puts "\nBump minor version\n"
          context.minor_bump
        when 'release'
          puts "\nBump major version\n"
          context.major_bump
        when 'test'
          puts "\nExecute tests\n"
          context.cucumber_test(deployer)
        when 'reset'
          puts "\nReset versionning\n"
          # context.cucumber_test(deployer)
        else
          puts "Unknown setting #{action}"
        end
      end
    end
  end
end