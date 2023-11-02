
module Context
  module Steps
    module RakeSteps
      def then_do_rake(rake_action)
        stop_test("L'action #{rake_action} à échouer", :rake_fail) unless system("cd habitat/plan.sh/; rake #{rake_action}") || true
      end

      def then_bump_version
        stop_test("Bumper la version a échoué", :rake_bump_fail) unless GVB.internal_revision.nil? || system("git version-bump patch")
      end

      def then_save_version
        stop_test("Bumper la version a échoué", :rake_bump_fail) unless write_cookbook_version 
      end
    end
  end
end
