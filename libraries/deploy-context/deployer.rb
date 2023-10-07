module Context
  module Deployer
    def self.set(deployer_class)
      @deployer = deployer_class if @deployer.nil?
      @deployer
    end

    def self.method_missing(method_name, *argv, &block)
      # puts "Searching method #{method_name}"
      is_deploy_context_respond_to_action = @deployer.respond_to?(method_name) && @deployer.actions_permitted?(method_name.to_s)
      if is_deploy_context_respond_to_action
        @deployer.execute_action(@deployer, method_name)
      else
        puts "\n\nUnavailable action '#{method_name}' for context #{@deployer.context_name} as #{@deployer.respond_to?(method_name)} and #{@deployer.actions_permitted?(method_name)} for #{@deployer.class}\n"
      end
    end
  end
end
