
require_relative 'deploy/context'
require_relative 'deploy/chef'
require_relative 'deploy/cookbook'
require_relative 'deploy/cucumber'
require_relative 'deploy/deployer'
require_relative 'deploy/git'
require_relative 'deploy/habitat'
require_relative 'deploy/ruby'
require_relative 'deploy/vagrant'

require_relative 'steps/compliance'
require_relative 'steps/cucumber'
require_relative 'steps/git'
require_relative 'steps/habitat'
require_relative 'steps/inspec'
require_relative 'steps/kitchen'
require_relative 'steps/knife'
require_relative 'steps/rake'
require_relative 'steps/ruby'
require_relative 'steps/supermarket'

require_relative 'steps/deploy'

module Context
  module CucumberSuiteHelper
    include Context::CommandHelper
    include DeployHelpers::DeployerHelper
    include DeployHelpers::ChefHelper
    include DeployHelpers::GitHelper
    include DeployHelpers::RubyHelper
    include DeployHelpers::ContextHelper
    include DeployHelpers::CookbookHelper
    include DeployHelpers::HabitatHelper
    include DeployHelpers::CucumberHelper
    
    include Studio::Base
    include Studio::Default

    include Steps::ComplianceSteps
    include Steps::Deploy
    include Steps::CucumberSteps
    include Steps::GitSteps
    include Steps::HabitatSteps
    include Steps::InspecSteps
    include Steps::KitchenSteps
    include Steps::KnifeSteps
    include Steps::RakeSteps
    include Steps::RubySteps
    include Steps::SupermarketSteps

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
      context_suite.status = case kitchen_status['last_action']
      when "verify"
        kitchen_status['last_error'].nil? ? :verified : :verification_fail
      when "converge"
        kitchen_status['last_error'].nil? ? :converged : :converge_fail
      when nil
        :destroyed
      else
        warning_context_log("Kitchen status", kitchen_status['last_action'].inspect)
        :unknown
      end
    end

    def dirty_branch?
      `git status --porcelain`.split('\n').count > 0
    end

    def branch_exist?
      system("git branch --list #{context_suite.branch_name}")
    end

    def git_commit_successfully?(context_suite)
      system("git commit --message 'Automatic cucumber commit on branch #{context_suite.branch_name}'")
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

    def verify_secret?(secret_key)
      system("hab origin secret list | grep #{secret_key}")
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
      debug_context_log 'Habitat status', "Get job status for #{context_suite.organisation_name}/#{context_suite.application_name}"
      `hab bldr job status --limit 1000 --origin #{context_suite.organisation_name} | grep  #{context_suite.organisation_name}/#{context_suite.application_name}`
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
      short_version = Gem::Version.new(GVB.version).canonical_segments[0..2].join('.')
      File.write('VERSION', short_version)
      File.write('DATE', GVB.date)
      File.write('habitat/plan.sh/VERSION', short_version)
      File.write('habitat/plan.sh/DATE', GVB.date)
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

    def command_available?(app_name, sub_command)
      system("knife #{app_name} #{sub_command}")
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
