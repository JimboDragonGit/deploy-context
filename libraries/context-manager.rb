
require_relative 'deploy-context/cucumber-studio'

module Context
  class Manager < DefaultStudio
    attr_reader :contexts

    # def initialize(context_organisation_name, deployer_context_name, deploycontext_folder, default_ruby_studio = nil)
    #   super(context_organisation_name, deployer_context_name, deploycontext_folder, default_ruby_studio)

    #   @contexts = Array.new
    # end

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
