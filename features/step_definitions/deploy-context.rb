extend Context::Steps::Deploy

deployer = Context::DeployContext.new(File.expand_path(__dir__, '../../'))

define_steps(deployer)
