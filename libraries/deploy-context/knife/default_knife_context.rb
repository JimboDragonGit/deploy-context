require 'chef/knife'

require_relative 'dummy_knife.rb'

module Context
  module Knife
    class DefaultKnifeContext < Chef::Knife
      include CommandHelper

      banner "knife default knife context"

      deps do
      end
    
      option :context_name,
        :long => '--context-name VALUE',
        :boolean => false,
        :description => "The name of the context we running on"
      
      option :context_folder,
      :long => '--context-path VALUE',
      :description => "Path of the context"

      option :organisation_name,
        :long => '--organisation-name VALUE',
        :description => "Organisation name of the context"

      def run
        if config[:context_name]
          log "Running on context #{config[:context_name]}, config = #{config.inspect}\n#{name_args}"
        else
          error_log self, "Running on context #{config[:context_name]}"
        end
      end
    end
  end
end
