begin
  require 'chef/knife'
rescue Exception => e
  puts "Failed to load chef/knife module, loading a dummy module instead"

  class Chef
    class Knife
      def self.banner(banner_flags)
      end

      def self.deps
      end

      def self.option(name,*argv)
      end
    end
  end
end

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
