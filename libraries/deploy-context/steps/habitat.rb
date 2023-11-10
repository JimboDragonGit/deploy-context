
module Context
  module Steps
    module HabitatSteps
      def given_plan(context_suite)
        stop_test("Habitat plan #{context_suite.plan_path} not given", :no_plan) unless Dir.exist?(context_suite.plan_path)
      end

      def when_initialize_habitat(context_suite)
        stop_test("Habitat plan #{context_suite.plan_path} not initialized", :no_studio) unless verify_habitat?
      end

      def when_secret_available(context_suite)
        stop_test("Habitat secrets #{context_suite.plan_path} not set", :no_secret) unless verify_secret?(context_suite.secret_key)
      end

      def then_build_plan(context_suite)
        stop_test("Habitat plan #{context_suite.plan_path} build fail", :build_fail) unless plan_build_successfully?
      end

      def then_start_job(context_suite)
        stop_test("Habitat plan builder #{context_suite.plan_path} failed", :builder_fail) unless system("hab bldr job start #{context_suite.organisation_name}/#{context_suite.application_name} x86_64-linux")
      end

      def when_project_end(context_suite)
        stop_test("Le projet n'est pas compléter", :not_accepted) unless context_suite.status == :accepted
      end

      def when_studio_success(context_suite)
        stop_test("Le studio est un échec", context_suite.status) unless context_suite.status != :ok
      end

      def when_dispatch_job(context_suite)
        warning_context_log('no_habitat_task_dispatched', "Aucun tâche de disponible sur l'origin #{context_suite.organisation_name}") unless habitat_new_task?
      end

      def then_wait_completion(context_suite)
        second_pass = 0
        while true do
          if habitat_new_task?
            context_log "Waiting for task... #{second_pass} seconds"
            sleep 1
            second_pass += 1
          else
            break
          end
        end
      end

      def then_promote_job(context_suite)
        stop_test("Promouvoir la tâche sur l'origin #{context_suite.organisation_name}", :habitat_promotion_fail) unless habitat_task_completed?
      end

      def when_update_job(context_suite)
        stop_test("Même tâche que son origin #{context_suite.organisation_name}", :same_last_build) unless habitat_task_different?
      end

      def when_job_completed(context_suite)
        stop_test("Même tâche que son origin #{context_suite.organisation_name}", :build_completed) unless habitat_task_completed?
      end

      def then_clean_project(context_suite)
        delete_file_only_if_exist(get_context_file(self, 'habitat/plan.sh/Gemfile.lock'))
      end

      def then_set_secret(context_suite)
        unless verify_secret?(context_suite.secret_key)
          warning_context_log(context_suite.secret_key, "ENV[#{context_suite.secret_key}] = #{ENV[context_suite.secret_key]}")
          hab_secret_update_cmd = "hab origin secret upload #{context_suite.secret_key} #{ENV[context_suite.secret_key]}"
          warning_context_log('hab_secret_update_cmd', hab_secret_update_cmd)
          stop_test("Secret non enregistré #{context_suite.organisation_name}", :no_save_secret) unless system(hab_secret_update_cmd)
        end
      end
    end
  end
end
