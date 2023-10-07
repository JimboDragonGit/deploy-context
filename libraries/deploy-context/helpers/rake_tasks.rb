module Context
  module RakeTasks
    def load_public_dependencies
      require 'rubygems'
      require 'bundler'
      # require 'bundler/setup'
      # require 'bundler/installer'
      
      require 'rdoc/task'
      
      require 'git-version-bump/rake-tasks'
      
      require 'cucumber'
      require 'cucumber/rake/task'

      require_relative '../../deploy-context'
    end

    def define_deploy_context_tasks
      load_public_dependencies
      Bundler::GemHelper.install_tasks

      Rake::RDocTask.new do |rd|
        rd.main = "README.md"
        rd.title = 'deploy-context'
        rd.rdoc_files.include("README.md", "lib/**/*.rb")
      end

      namespace :deploycontext do
        task :default => "deploycontext:test" do
          Context::DeployContext.deployer.cycle
        end

        task :bump => "deploycontext:commit" do
          Context::DeployContext.deployer.bump
        end

        task :test => "deploycontext:help" do
          Context::DeployContext.deployer.test
        end

        task :release => "deploycontext:commit"  do
          Context::DeployContext.deployer.release
        end

        task :commit => "deploycontext:default" do
          Context::DeployContext.deployer.commit
        end

        task :push => "deploycontext:commit" do
          Context::DeployContext.deployer.push
        end

        task :help do
          Context::DeployContext.deployer.help
        end

        namespace :studio do
          task :promote  => "deploycontext:studio:release" do
            Context::DeployContext.deployer.do_promote
          end

          task :build  => "deploycontext:studio:habitat" do
            Context::DeployContext.deployer.do_build
          end

          task :install  => "deploycontext:studio:build" do
            Context::DeployContext.deployer.do_install
          end

          task :release  => "deploycontext:studio:install" do
            Context::DeployContext.deployer.do_release
          end

          task :habitat do
            Context::DeployContext.deployer.do_build_in_habitat
          end

          task :kitchen do
            Context::DeployContext.deployer.test_with_kitchen
          end
        end

        namespace :plan do
          task :do_mix_cookbook do
            Context::DeployContext.deployer.do_mix_cookbook
          end

          task :do_begin do
            Context::DeployContext.deployer.do_begin
          end

          task :do_download do
            Context::DeployContext.deployer.do_download
          end

          task :do_verify do
            Context::DeployContext.deployer.do_verify
          end

          task :do_clean do
            Context::DeployContext.deployer.do_clean
          end

          task :do_unpack do
            Context::DeployContext.deployer.do_unpack
          end

          task :do_prepare do
            Context::DeployContext.deployer.do_prepare
          end

          task :do_build do
            Context::DeployContext.deployer.do_build
          end

          task :do_check do
            Context::DeployContext.deployer.do_check
          end

          task :do_install do
            Context::DeployContext.deployer.do_install
          end

          task :do_strip do
            Context::DeployContext.deployer.do_strip
          end

          task :do_end do
            Context::DeployContext.deployer.do_end
          end
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
    end
  end
end
