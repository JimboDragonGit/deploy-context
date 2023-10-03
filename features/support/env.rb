require 'deploy-context'

DEPLOYER = Context::DeployContext.new(ENV['DEPLOY_CONTEXT_FOLDER'])

def deployer
  DEPLOYER
end
