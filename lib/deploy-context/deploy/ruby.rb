module Context
  module RubyDeployerHelper
    def ruby_build(context)
      git_build(context)
      Dir.chdir context.context_dir(context)
      puts "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created"
      gem ["build #{context.context_name}.gemspec"]
    end

    def ruby_release(context)
      Dir.chdir context.context_dir(context)
      gem ["push #{context.context_name}-0.1.0.gem"]
    end

    def ruby_install(context)
      gem ['install', context.context_name]
    end
  end
end