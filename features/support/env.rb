require 'deploy-context'

ENV['DEPLOY_CONTEXT_FOLDER'] = Context::DeployContext.new(ENV['DEPLOY_CONTEXT_FOLDER'])

def deployer
  ENV['DEPLOY_CONTEXT_FOLDER']
end
