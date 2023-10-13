
require_relative 'context-knife-context'

module Context
  module DeployKnifeConstant
    def organisation_name
      'deploy-context'
    end

    def context_name
      'deploy-context'
    end

    def context_folder
      File.join(ENV['HOME'], 'deploy-context')
    end
  end

  class DeployKnifeContext < Manager
    banner "knife deploy knife context"

    deps do
      Knife::DefaultKnifeContext.load_deps
    end

    option :omg,
      :short => '-O',
      :long => '--omg',
      :description => "I'm so excited! 9"

    def run
      if config[:omg]
        puts "OMG HELLO WORLD!!!9!!99"
      else
        puts "I am just a fucking example. 9"
      end
    end
  end

  class DeployContext < Manager
    include DeployKnifeConstant
    banner "knife deploy context"

    deps do
      Knife::DefaultKnifeContext.load_deps
    end

    def run
      run_cmd = %w(knife context) + [name_args[0], 'studio'] + name_args[1...]
      execute_command(run_cmd)
    end
  end
end
