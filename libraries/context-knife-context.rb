puts "On me charge à #{__FILE__}"

require_relative 'context-manager'

module Context
  class ContextKnifeContext < DefaultStudio
    banner "knife context knife context"

    deps do
      Knife::DefaultKnifeContext.load_deps
      # puts "S'a prend ça"
      # require "chef/json_compat"
      # true
    end

    option :omg,
      :short => '-O',
      :long => '--omg',
      :description => "I'm so excited! 8"

    # set_knife(DeployContext)

    # def self.deployer(origin_folder = ENV.key?('DEPLOYCONTEXTFOLDER') ? ENV['DEPLOYCONTEXTFOLDER'] : Dir.pwd)
    #   Studio::Deployer.set(DeployContext.new(origin_folder))
    #   Studio::Deployer
    # end

    # def initialize(deploycontext_folder)
    #   super('jimbodragon', 'deploy-context', deploycontext_folder, self)

    #   abort("No context_name :(") if context_name.nil? || context_name.empty?
    # end

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