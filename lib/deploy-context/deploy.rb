require_relative 'context/deploy'

module Context
  class Deploy
    include DeployHelper

    attr_reader :context_name
    attr_reader :context_folder

    def initialize(context_name, deploycontext_folder)
      @context_name = context_name
      @context_folder = deploycontext_folder
    end

    def present_localy?
      Dir.exist?(context_folder)
    end

    def check_folder(folder)
      FileUtils.mkdir_p(context_folder) unless present_localy?
    end

    def version
      Dir.chdir(context_folder)
      GVB.version
    end
  end
end