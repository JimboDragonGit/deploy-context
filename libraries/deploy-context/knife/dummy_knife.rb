require 'chef/knife'

puts "Moi aussi on me charge #{__FILE__}"
module Context
  module Knife
    class MannequinKnifeContext < Chef::Knife
      banner "knife mannequin knife context"

      deps do
        # Chef::Knife::BaseVsphereCommand.load_deps
        puts "S'a prend ça en 7"
        require "chef/json_compat"
        true
      end
    
      option :omg,
        :short => '-O',
        :long => '--omg',
        :boolean => true,
        :description => "I'm so excited! 7"

      def run
        # deployer.send(config[:omg])
        if config[:omg]
          # Oh yeah, we are pumped.
          puts "OMG HELLO WORLD!!!7!!77"
        else
          # meh
          puts "I am just a fucking example. 7"
        end
      end
    end
  end
end
