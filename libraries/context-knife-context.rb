
require_relative 'context-manager'

module Context
  class ContextKnifeContext < DefaultStudio
    banner "knife context knife context"

    deps do
      Knife::DefaultKnifeContext.load_deps
    end

    option :context,
      :description => "Load an object internally on it"

    def run
      # Context::DeployContext.deployer.send(config[:omg])
      if config[:omg]
        # Oh yeah, we are pumped.
        puts "OMG HELLO WORLD!!!8!!88"
      else
        # meh
        puts "I am just a fucking example. 8"
      end
    end
  end
end
