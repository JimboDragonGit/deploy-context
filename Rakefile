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

require_relative 'lib/deploy-context/helpers/rake'
