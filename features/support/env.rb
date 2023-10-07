
require_relative '../../libraries/deploy-context'

def context_exec(command)
  Context::DeployContext.deployer.execute_command(command)
end

chef_gem 'cucumber'
