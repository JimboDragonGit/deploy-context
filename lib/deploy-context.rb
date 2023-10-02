
require 'git-version-bump'

module Context
  class Deploy
    attr_reader :context_name

    def initialize(context_name)
      @context_name = context_name
    end

    def ruby_build(context)
      git ["clone git@github.com:JimboDragonGit/#{context.context_name}.git"] if ::Dir.exist?(context_dir(context.context_name))
      Dir.chdir context_dir(context.context)
      puts "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created"
      gem ["build #{context.context_name}.gemspec"]
      gem ["push #{context.context_name}-0.1.0.gem"]
      gem ['install', context.context_name]
      git ['add .']
      git ['commit -m "Create deploy-context first commit"']
      git ['push']
    end

    def contexts_container
      tmp_folder = Gem.win_platform? ? 'C:/temp/' : '/tmp'
      File.join(tmp_folder, 'contexts')
    end
    
    def context_dir(context)
      File.join(contexts_container, context.context_name)
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
  end
end