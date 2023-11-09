
module Context
  module Steps
    module ComplianceSteps
      def when_report_succeeded(context_suite)
        stop_test("Cucumber #{context_suite.profile_name} is unavailable", :no_profile) unless execute_command("knife deploy context cucumber #{context_suite.rapport_name}_json")

        results = JSON.parse(::File.read(::File.join('logs/json', "#{context_suite.rapport_name}_features_report.json")))

        step_success_counter = 0
        step_fail_counter = 0
        step_total_counter = 0

        step_unknown_counter = 0

        results.each do |result|
          result['elements'].each do |element_of|
            element_of['steps'].each do |a_step|
              case a_step['result']['status']
              when 'passed'
                step_success_counter += 1
                step_total_counter += 1
              when 'failed'
                step_fail_counter += 1
                step_total_counter += 1
              else
                step_unknown_counter += 1
                step_total_counter += 1
              end
            end
          end
        end

        warning_context_log "step_success_counter", "Nombre d'étape parcouru: #{step_success_counter}"
        warning_context_log "step_fail_counter", "Nombre d'étape parcouru: #{step_fail_counter}"
        warning_context_log "step_total_counter", "Nombre d'étape parcouru: #{step_total_counter}"
        warning_context_log "step_unknown_counter", "Nombre d'étape parcouru: #{step_unknown_counter}"

        stop_test("Cucumber #{context_suite.profile_name} is unavailable", :no_profile) if context_suite.require_inspec_success > step_success_counter
      end
    end
  end
end
