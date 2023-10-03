require 'deploy-context'

DEPLOYER = Context::DeployContext.new(File.join(ENV['HOME'], 'deploy-context'))

def deployer
  DEPLOYER
end
