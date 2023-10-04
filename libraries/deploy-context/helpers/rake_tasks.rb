require 'rubygems'
require 'bundler'

Bundler::GemHelper.install_tasks

require 'rdoc/task'

Rake::RDocTask.new do |rd|
	rd.main = "README.md"
	rd.title = 'deploy-context'
	rd.rdoc_files.include("README.md", "lib/**/*.rb")
end

require 'git-version-bump/rake-tasks'

require_relative '../../deploy-context'

namespace :deploycontext do
  task :default => "deploycontext:test" do
    Context::DeployContext.deployer.execute_action(Context::DeployContext.deployer, 'once')
  end

  task :bump do
    Context::DeployContext.deployer.execute_action(Context::DeployContext.deployer, 'bump')
  end

  task :test => "deploycontext:help" do
    Context::DeployContext.deployer.execute_action(Context::DeployContext.deployer, 'test')
  end

  task :help do
    Context::DeployContext.deployer.execute_action(Context::DeployContext.deployer, 'help')
  end
end
