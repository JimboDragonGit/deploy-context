
module Context
  module Steps
    module KitchenSteps
      def given_kitchen(context_suite)
        stop_test("Kitchen suite #{context_suite.kitchen_name} unavailable", :no_kitchen) unless kitchen_suite_exist?
      end

      def when_intializing(context_suite)
        stop_test('Le projet est déjà initialisé', :already_initialized) if context_suite.status == :no_kitchen
      end

      def then_converge(context_suite)
        stop_test("la suite kitchen #{context_suite.suite_kitchen} est en échec", :converge_fail) unless kitchen_converged_successfully?
      end

      def then_check_ok(context_suite)
        context_suite.status = if verify_kitchen? && verify_habitat?
          :ok
        else
          :not_all_ok
        end
        stop_test("la suite kitchen #{context_suite.suite_kitchen} est en échec", context_suite.status) if context_suite.status == :no_kitchen
      end
      
      def when_destroy_kitchen(context_suite)
        verify_kitchen_status
        stop_test("La suite #{context_suite.suite_kitchen} n'est pas détruit", context_suite.status) unless context_suite.status == :destroyed
      end

      def when_converge_kitchen(context_suite)
        verify_kitchen_status
        stop_test("La suite #{context_suite.suite_kitchen} n'est pas convergée", context_suite.status) unless context_suite.status == :converged
      end

      def when_validate_kitchen(context_suite)
        verify_kitchen_status
        stop_test("La suite #{context_suite.suite_kitchen} n'est pas vérifiée", context_suite.status) unless context_suite.status == :verified
      end

      def when_kitchen_fail(context_suite)
        verify_kitchen_status
        stop_test("La suite #{context_suite.suite_kitchen} est vérifié", context_suite.status) unless context_suite.status != :verified
      end

      def then_destroy_kitchen(context_suite)
        stop_test("Kitchen suite #{context_suite.kitchen_suite} destruction failed", :no_kitchen) unless kitchen_destroyed_correctly?
      end

      def then_verify_kitchen(context_suite)
        stop_test("Kitchen suite #{context_suite.kitchen_suite} verification failed", :verify_kitchen_failed) unless verify_kitchen?
      end

      def then_test_kitchen(context_suite)
        stop_test("Kitchen suite #{context_suite.kitchen_suite} test failed", :test_kitchen_failed) unless kitchen_tested_successfully?
      end
    end
  end
end
