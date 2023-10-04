
require_relative '../../lib/deploy-context'

def context_exec(command)
  Context::DeployContext.deployer.execute_command(command.join(' '))
end
