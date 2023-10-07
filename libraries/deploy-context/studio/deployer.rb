module Context
  module Studio
    module Deployer
      def self.set(deployer_class)
        @deployer = deployer_class if @deployer.nil?
        @deployer
      end

      def self.execute(action)
        @deployer.send(action)
      end

      def self.method_missing(method_name, *argv, &block)
        @deployer.debug_log "Searching method #{method_name} in context #{@deployer}"
        is_deploy_context_respond_to_action = @deployer.respond_to?(method_name) && @deployer.actions_permitted?(method_name.to_s)
        if is_deploy_context_respond_to_action
          @deployer.execute_action(@deployer, method_name)
        else
          @deployer.debug_log "\n\nUnavailable action '#{method_name}' for context #{@deployer.context_name} as #{@deployer.respond_to?(method_name)} and #{@deployer.actions_permitted?(method_name)} for #{@deployer.class}\n"
        end
      end
    end
  end
end
