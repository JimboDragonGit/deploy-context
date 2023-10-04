module Context
  class Manager
    attr_reader :deployers

    def get_deployer(context_name, context_path)
      @deployers = Hash.new if @deployers.nil?
      @deployers['deploycontext'] = Context::DeployContext.new(context_path) unless deployers.key?(context_name)
      deployers[context_name]
    end
  end
end
