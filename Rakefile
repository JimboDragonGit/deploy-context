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

task :default do
  require_relative 'lib/deploy-context'
  require_relative 'lib/deploy-context/deploy'
  
  deployer = Context::DeployContext.new(__dir__)
  deployer.cycle
end
