
module Context
  module Steps
    module ComplianceSteps
      def when_report_succeeded(context_suite)
        extend_command = ["#{context_suite.rapport_name}_json"]
        extend_command << context_suite.specific_step unless context_suite.specific_step
        is_step_kitchen_command = if context_suite.rapport_name.include?('kitchen')
          context_suite.specific_step.kind_of? String && ! context_suite.specific_step.empty?
        else
          false
        end

        stop_test("La commande kitchen ne contien pas d'étape", :no_kitchen_step) if is_step_kitchen_command
        stop_test("Cucumber Report #{context_suite.rapport_name} is unavailable", :no_report) unless execute_command(%w(knife deploy context cucumber) + extend_command)

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
        warning_context_log "step_skip_counter", "Nombre d'étape parcouru: #{step_skip_counter}"
        warning_context_log "step_total_counter", "Nombre d'étape parcouru: #{step_total_counter}"
        warning_context_log "step_unknown_counter", "Nombre d'étape parcouru: #{step_unknown_counter}"

        status_helper = [
          [
            "Success: #{step_success_counter}",
            "Failed: #{step_fail_counter}",
            "Skipped: #{step_skip_counter}",
            "Unknown: #{step_unknown_counter}",
            "Total #{step_total_counter}",
          ].join(' | '),
          step_unknown_counter > 0 ? "Missing status: #{JSON.pretty_generate(unknown_status)}" : ""
        ].join("\n\n")

        report_helper = "#{context_suite.rapport_name}::#{context_suite.specific_step} => '#{extend_command}'"

        has_not_enough_success = context_suite.require_inspec_success > step_success_counter
        has_too_much_failure = context_suite.maximum_inspec_failure < step_fail_counter
        has_too_much_skipped = context_suite.maximum_inspec_skipped < step_skip_counter

        stop_test("Le rapport #{report_helper} n'a pas atteint son objectif (#{status_helper})", :not_enough_success) if has_not_enough_success
        stop_test("Le rapport #{report_helper} a trop de défaillance (#{status_helper})", :too_much_failure) if has_too_much_failure
        stop_test("Le rapport #{report_helper} a trop d'élément non analysé (#{status_helper})", :too_much_skip) if has_too_much_skipped
      end
    end
  end
end
