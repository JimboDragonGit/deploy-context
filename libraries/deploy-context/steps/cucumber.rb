
module Context
  module Steps
    module CucumberSteps
      def given_test_suite(context_suite)
        stop_test("Cucumber #{context_suite.test_suite} is unavailable", :no_cucumber) unless system("cucumber -d")
      end

      def test_successfull?(context_suite)
        stop_test("Cucumber test #{context_suite.test_suite} failed on execution", :cucumber_test_issue) unless system("knife context deploy --context-name #{context_suite.test_suite}")
      end
      
      def given_profile_name(context_suite)
        stop_test("Cucumber #{context_suite.profile_name} is unavailable", :no_profile) unless system("cucumber --profile #{context_suite.profile_name}")
      end

      def report_the_report(context_suite)
        stop_test("Cucumber test report #{context_suite.test_suite} failed to sent", :cucumber_test_issue) unless system("cucumber --profile #{context_suite.profile_name}")
      end
    end
  end
end
