module Context
  module RakeTasks
    def define_deploy_context_tasks(deployer)
      deployer.load_public_dependencies
      Bundler::GemHelper.install_tasks

      Rake::RDocTask.new do |rd|
        rd.main = "README.md"
        rd.title = 'deploy-context'
        rd.rdoc_files.include("README.md", "lib/**/*.rb")
      end

      namespace :deploycontext do
        task :mix_cookbook => "deploycontext:push_cookbook" do
          deployer.do_mix_cookbook
        end

        task :push_cookbook => "deploycontext:install" do
          deployer.do_end
        end

        task :install do
          deployer.do_install
        end

        # task :bump => "deploycontext:commit" do
        #   deployer.bump
        # end

        # task :test => "deploycontext:help" do
        #   deployer.test
        # end

        # task :release => "deploycontext:commit"  do
        #   deployer.release
        # end

        # task :commit => "deploycontext:default" do
        #   deployer.commit
        # end

        # task :push => "deploycontext:commit" do
        #   deployer.push
        # end

        task :help do
          deployer.help
        end

        namespace :studio do
          task :promote  => "deploycontext:studio:release" do
            deployer.do_end
          end

          task :build  => "deploycontext:studio:habitat" do
            deployer.do_build
          end

          task :install  => "deploycontext:studio:build" do
            deployer.do_install
          end

          task :release  => "deploycontext:studio:install" do
            deployer.do_release
          end

          task :habitat do
            deployer.do_build_in_habitat
          end

          task :kitchen do
            deployer.test_with_kitchen
          end
        end

        namespace :plan do
          task :do_mix_cookbook do
            deployer.do_mix_cookbook
          end

          task :do_begin do
            deployer.do_begin
          end

          task :do_download do
            deployer.do_download
          end

          task :do_verify do
            deployer.do_verify
          end

          task :do_clean do
            deployer.do_clean
          end

          task :do_unpack do
            deployer.do_unpack
          end

          task :do_prepare do
            deployer.do_prepare
          end

          task :do_build do
            deployer.do_build
          end

          task :do_check do
            deployer.do_check
          end

          task :do_install do
            deployer.do_install
          end

          task :do_strip do
            deployer.do_strip
          end

          task :do_end do
            deployer.do_end
          end
        end

        namespace :deployer do
          task :cookbook do
            deployer.cookbook_test(deployer)
          end

          task :cucumber do
            deployer.cucumber_test(deployer)
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
