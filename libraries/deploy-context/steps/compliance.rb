
module Context
  module Steps
    module ComplianceSteps
      def when_report_succeeded(context_suite)
        stop_test("Cucumber Report #{context_suite.rapport_name} is unavailable", :no_report) unless execute_command(%w(knife deploy context cucumber) + ["#{context_suite.rapport_name}_json"])

        results = JSON.parse(::File.read(::File.join('logs/json', "#{context_suite.rapport_name}_features_report.json")))

        step_success_counter = 0
        step_fail_counter = 0
        step_skip_counter = 0
        step_total_counter = 0

        step_unknown_counter = 0
        unknown_status = Hash.new

        results.each do |result|
          result['elements'].each do |element_of|
            element_of['steps'].each do |a_step|
              case a_step['result']['status']
              when 'passed'
                step_success_counter += 1
              when 'failed'
                step_fail_counter += 1
              when 'skipped'
                step_skip_counter += 1
              else
                unknown_status[a_step['result']['status']] = 0 unless unknown_status.key?(a_step['result']['status'])
                step_unknown_counter += 1
                unknown_status[a_step['result']['status']] += 1
              end
              step_total_counter += 1
            end
          end
        end

        warning_context_log "step_success_counter", "Nombre d'étape parcouru: #{step_success_counter}"
        warning_context_log "step_fail_counter", "Nombre d'étape parcouru: #{step_fail_counter}"
        warning_context_log "step_total_counter", "Nombre d'étape parcouru: #{step_total_counter}"
        warning_context_log "step_unknown_counter", "Nombre d'étape parcouru: #{step_unknown_counter}"

        message_helper = [
          [
            "Success: #{step_success_counter}",
            "Failed: #{step_fail_counter}",
            "Unknown: #{step_unknown_counter}",
            "Total #{step_total_counter}",
          ].join(' | '),
          "Missing status: #{JSON.pretty_generate(unknown_status)}"
        ].join('\n\n')

        stop_test("Le rapport #{context_suite.rapport_name} n'a pas atteint son objectif #{message_helper}", :not_enough_success) if context_suite.require_inspec_success > step_success_counter
        stop_test("Le rapport #{context_suite.rapport_name} a trop de défaillance #{message_helper}", :no_profile) if context_suite.maximum_inspec_failure >= step_fail_counter
      end
    end
  end
end
