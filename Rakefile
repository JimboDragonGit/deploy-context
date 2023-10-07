require_relative 'libraries/deploy-context'

extend Context::RakeTasks

define_deploy_context_tasks(Context::DeployContext.new(Dir.pwd))

# task :default => "deploycontext:default"

task :default => "deploycontext:mix_cookbook"
