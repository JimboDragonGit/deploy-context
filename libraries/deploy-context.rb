
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

    # set_knife(DeployContext)

    def self.deployer(origin_folder = ENV.key?('DEPLOYCONTEXTFOLDER') ? ENV['DEPLOYCONTEXTFOLDER'] : Dir.pwd)
      Studio::Deployer.set(DeployContext.new)
      Studio::Deployer
    end

    # def initialisation(argv)
    #   config[:context_name] = 'deploycontext'
    # end

    # def initialize(deploycontext_folder)
    #   super('jimbodragon', 'deploy-context', deploycontext_folder, self)

    #   abort("No context_name :(") if context_name.nil? || context_name.empty?
    # end

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
