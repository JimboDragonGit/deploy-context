require 'chef/knife'

module Context
  module Knife
    class MannequinKnifeContext < Chef::Knife
      banner "knife mannequin knife context"

      deps do
      end
    
      option :mannequin,
        :description => "Just a dummy example"

      def run
        # deployer.send(config[:omg])
        if config[:mannequin]
          # Oh yeah, we are pumped.
          puts "Dummy Mannequin ;)"
        else
          # meh
          puts "Where is my Dummy Mannequin!!!!"
        end
      end
    end
  end
end
