
require_relative 'deploy-context/habitat-studio'

module Context
  class Manager < HabitatStudio
    attr_reader :contexts

    def initialize(organisation_name, context_name, deploycontext_folder)
      super(organisation_name, context_name, deploycontext_folder)

      @contexts = Array.new

      abort("No context_name :(") if context_name.nil? || context_name.empty?
    end

    # 2
    def do_download
      super
      contexts.each do |context|
        context.do_download
      end
      true
    end
    
    # 3
    def do_verify
      super
      contexts.each do |context|
        context.do_verify
      end
      true
    end
    
    # 4
    def do_clean
      super
      contexts.each do |context|
        context.do_clean
      end
      true
    end
    
    # 5
    def do_unpack
      super
      contexts.each do |context|
        context.do_unpack
      end
      true
    end
    
    # 6
    def do_prepare
      super
      contexts.each do |context|
        context.do_prepare
      end
      true
    end
    
    # 7
    def do_build
      super
      contexts.each do |context|
        context.do_build
      end
      true
    end
    
    # 8
    def do_check
      super
      contexts.each do |context|
        context.do_check
      end
      true
    end
    
    # 9
    def do_install
      super
      contexts.each do |context|
        context.do_install
      end
      true
    end
    
    # 10
    def do_strip
      super
      def do_install
        contexts.each do |context|
          context.do_strip
        end
        true
      end
    end
    
    # 11
    def do_end
      super
      contexts.each do |context|
        context.do_end
      end
      true
    end
  end
end
