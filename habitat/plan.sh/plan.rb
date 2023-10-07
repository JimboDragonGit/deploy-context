require_relative '../../libraries/deploy-context'

Context::DeployContext.deployer('/src').send(ARGV[0])
