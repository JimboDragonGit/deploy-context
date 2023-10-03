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
      state_action = if action.nil?
        context.cycle
        false
      else
        case action
        when 'once'
          puts "\nExecute only once\n"
          context.cycle
          true
        when 'always'
          puts "\nAlways in execution\n"
          while true do
            context.cycle
          end
          true
        when 'bump'
          puts "\nBump minor version\n"
          context.patch_bump
          true
        when 'release'
          puts "\nBump major version\n"
          context.minor_bump
          true
        when 'upgrade'
          puts "\nBump major version\n"
          context.major_bump
          true
        when 'test'
          puts "\nExecute tests\n"
          context.cucumber_test(context)
          true
        when 'reset'
          puts "\nReset versionning\n"
          system('rake')
          # context.cucumber_test(deployer)
          true
        else
          puts "Unknown setting #{action}"
          false
        end
      end
      context.commit
      if state_action
        puts "Action #{action} executed correctly in context #{context}"
      else
        abort("Failed to execute action #{action} in context #{context}")
      end
    end
  end
end
