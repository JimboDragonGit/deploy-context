
require_relative 'context-knife-context'

module Context
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
    banner "knife deploy context"

    deps do
      Knife::DefaultKnifeContext.load_deps
      # puts "S'a prend ça"
      # require "chef/json_compat"
      # true
    end

    option :omg,
      :short => '-O',
      :long => '--omg',
      :description => "I'm so excited! 4"

    def run
      # Context::DeployContext.deployer.send(config[:omg])
      if config[:omg]
        # Oh yeah, we are pumped.
        puts "OMG HELLO WORLD!!!4!!44"
      else
        # meh
        puts "I am just a fucking example. 4"
      end
    end
  end
end
