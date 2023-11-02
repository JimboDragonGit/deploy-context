
module Context
  module Steps
    module GitSteps
      def given_branch(context_suite)
        stop_test("Git branch #{context_suite.branch_name} unavailable", :no_branch) unless branch_exist?
      end

      def when_dirty_branch(context_suite)
        stop_test("Git branch #{context_suite.branch_name} is not dirty", :not_dirty) unless dirty_branch?
      end

      def when_clean_branch(context_suite)
        stop_test("Git branch #{context_suite.branch_name} is dirty", :is_dirty) if dirty_branch?
      end

      def then_add_modification(context_suite)
        stop_test("Git branch #{context_suite.branch_name} modifications cannot be added", :git_add_issue) unless system('git add .')
      end

      def then_commit_internal(context_suite)
        stop_test("Git branch #{context_suite.branch_name} commit issue", :commit_issue) unless git_commit_successfully?
      end

      def then_merge_branch(context_suite)
        stop_test("Git branch #{context_suite.branch_name} could't merge with master branch", :merge_issue) unless merge_with_branch_successfull?(context_suite.branch_name)
      end

      def given_master_branch(context_suite)
        stop_test("Issue switching to master", :master_switch_issue) unless system('git checkout master')
      end

      def then_push_git(context_suite)
        stop_test("Le déploiment vers son origine lointaine à échouer", :git_push_issue) unless system('git push')
      end

      def then_push_branch(context_suite)
        stop_test("Le déploiment de la branch #{context_suite.branch_name} vers son origine lointaine à échouer", :git_push_branch_issue) unless system("git push --set-upstream origin #{context_suite.branch_name}")
      end

      def then_checkout_branch(context_suite)
        stop_test("Le déploiment vers son origine lointaine à échouer", :git_checkout_issue) unless switch_branch_successful?
      end

      def delete_status_file(context_suite)
        File.delete('deploy-status.json') if File.exist? 'deploy-status.json'
      end

      def then_pull_origin
        stop_test("Le récupération avec son origine lointaine à échouer", :git_pull_issue) unless system('git pull')
      end
    end
  end
end
