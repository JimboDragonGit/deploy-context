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

require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

require_relative '../../deploy-context'

namespace :deploycontext do
  task :default => "deploycontext:test" do
    Context::DeployContext.deployer.execute_action(Context::DeployContext.deployer, 'cycle')
  end

  task :bump do
    Context::DeployContext.deployer.execute_action(Context::DeployContext.deployer, 'bump')
  end

  task :test => "deploycontext:help" do
    Context::DeployContext.deployer.execute_action(Context::DeployContext.deployer, 'test')
  end

  task :release => "deploycontext:default"  do
    Context::DeployContext.deployer.execute_action(Context::DeployContext.deployer, 'release')
  end

  task :help do
    Context::DeployContext.deployer.execute_action(Context::DeployContext.deployer, 'help')
  end

  namespace :deployer do
    task :cookbook do
      Context::DeployContext.deployer.cookbook_test(Context::DeployContext.deployer)
    end

    task :cucumber do
      Context::DeployContext.deployer.cucumber_test(Context::DeployContext.deployer)
    end
  end

  namespace :features do
    Cucumber::Rake::Task.new(:strict) do |t|
      t.cucumber_opts = "--format pretty" # Any valid command line option can go here.
      t.profile = "strict"
    end
  
    Cucumber::Rake::Task.new(:html_report) do |t|
      t.cucumber_opts = "--format pretty" # Any valid command line option can go here.
      t.profile = "html_report"
    end
  end
end
