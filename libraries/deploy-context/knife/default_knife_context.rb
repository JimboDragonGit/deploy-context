require 'chef/knife'

require_relative 'dummy_knife.rb'

module Context
  module Knife
    class DefaultKnifeContext < Chef::Knife
      banner "knife default knife context"

      deps do
      end
    
      option :omg,
        :short => '-O',
        :long => '--omg',
        :boolean => true,
        :description => "I'm so excited! 7"

      def run
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
