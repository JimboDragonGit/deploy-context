require 'deploy-context'

def deployer
  Context::DeployContext.deployer
end

def context_exec(command)
  system(command.join(' '))
end
