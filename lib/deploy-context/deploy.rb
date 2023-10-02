require_relative 'context/deploy'

module Context
  class Deploy
    include DeployHelper

    attr_reader :context_name

    def initialize(context_name)
      @context_name = context_name
      FileUtils.mkdir_p(contexts_container) unless ::Dir.exist?(contexts_container)
    end
  end
end