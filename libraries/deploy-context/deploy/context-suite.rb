
module Context
  module DeployHelpers
    module ContexSuiteHelper
      def context_suite
        if @context_suite.nil?
          @context_suite = OpenStruct.new
          @context_suite.status_file = 'deploy-status.json'
          # @context_suite.suite_kitchen = "patatae"
          @context_suite.status = :initialisation
        end
        @context_suite
      end

      def verify_kitchen_status
        context_suite.status = if kitchen_status['last_action'] == "verify" && kitchen_status['last_error'].nil?
          :verified
        else
          :verification_fail
        end
      end

      def dirty_branch?
        `git status --porcelain`.split('\n').count > 0
      end

      def branch_exist?
        system("git branch --list #{context_suite.branch_name}")
      end

      def git_commit_successfully?
        system("git commit -m 'Automatic cucumber commit on branch #{context_suite.branch_name}'")
      end

      def merge_with_branch_successfull?(source_branch)
        system("git merge #{source_branch} #{context_suite.branch_name}")
      end

      def merge_to_master_successfull?
        merge_with_branch_successfull?(context_suite.branch_name, 'master')
      end

      def switch_branch_successful?
        system("git checkout #{context_suite.branch_name}")
      end

      def kitchen_suite_exist?
        system("kitchen list #{context_suite.suite_kitchen}")
      end

      def verify_kitchen?
        system("kitchen verify #{context_suite.suite_kitchen}")
      end

      def kitchen_converged_successfully?
        system("kitchen converge #{context_suite.suite_kitchen}")
      end

      def kitchen_destroyed_correctly?
        system("kitchen destroy #{context_suite.suite_kitchen}")
      end

      def kitchen_tested_successfully?
        system("kitchen test #{context_suite.suite_kitchen}")
      end

      def habitat_task_different?
        jop_id = last_job_status[1]
        jop_id != File.read('HAB_BUILD_ID')
      end

      def habitat_task_completed?
        jop_status = last_job_status[2]
        jop_status == 'Complete'
      end

      def job_status_raw
        `hab bldr job status --origin #{context_suite.organisation_name} | grep  #{context_suite.organisation_name}/#{context_suite.application_name}`
      end

      def last_job_status
        job_status_arr = job_status_raw.split('\n')
        jop_status = job_status_arr[0].split(' ')
      end

      def habitat_new_task?
        jop_status = last_job_status[2]
        jop_status == 'Dispatching'
      end

      def write_build_id
        jop_id = last_job_status[1]
        File.write('HAB_BUILD_ID', jop_id)
      end

      def write_cookbook_version
        File.write('VERSION', GVB.version)
        File.write('DATE', GVB.date)
        File.write(File.join('habitat/plan.sh', 'VERSION'), GVB.version)
        File.write(File.join('habitat/plan.sh', 'DATE'), GVB.date)
      end

      def verify_habitat?
        system("hab studio run echo")
      end

      def plan_build_successfully?
        system("hab studio build #{context_suite.plan_path}")
      end

      def context_status
        JSON.parse(File.read(context_suite.status_file))[:status]
      end

      def kitchen_status
        JSON.parse(`kitchen list #{context_suite.suite_kitchen} --json`).detect{|suite| suite['instance'].include?(context_suite.suite_kitchen)}
      end

      def command_available?(context_name, sub_command)
        system("knife #{context_name} #{sub_command}")
      end

      def stop_test(message, status)
        wrap_message = "#{status}:: #{message}"
        update_status status
        abort(wrap_message)
      end

      def update_status(new_status)
        context_suite.status = new_status
        update_status_file
      end

      def update_status_file
        File.write(context_suite.status_file, JSON.pretty_generate({
          status_file: context_suite.status_file,
          kitchen_suite: context_suite.kitchen_suite,
          plan_path: context_suite.plan_path,
          branch_name: context_suite.branch_name,
          status: context_suite.status,
          }
        ))
      end
    end
  end
end