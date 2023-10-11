
module ContextSuite
  def context_suite
    if @context_suite.nil?
      @context_suite = OpenStruct.new
      @context_suite.status_file = 'deploy-status.json'
      # @context_suite.suite_kitchen = "patatae"
      @context_suite.status = :initialisation
      @context_suite.kitchen = OpenStruct.new
      @context_suite.habitat = OpenStruct.new
    end
    @context_suite
  end

  def verify_kitchen_status
    context_suite.kitchen.status = if kitchen_status['last_action'] == "verify" && kitchen_status['last_error'].nil?
      :verified
    else
      :verification_fail
    end
  end

  def kitchen_suite_exist?
    system("kitchen list #{context_suite.suite_kitchen}")
  end

  def verify_kitchen?
    system("kitchen verify #{context_suite.suite_kitchen}")
  end

  def verify_habitat?
    system("hab studio run echo")
  end

  def branch_exist?
    system("git branch --list #{context_suite.branch_name}")
  end

  def git_commit_successfully?
    system("git commit -m 'Automatic cucumber commit on branch #{context_suite.branch_name}'")
  end

  def push_to_master_successfull?
    system("git merge #{context_suite.branch_name} master")
  end

  def plan_build_successfully?
    system("hab studio build #{context_suite.plan_path}")
  end

  def kitchen_converged_successfully?
    system("kitchen converge #{context_suite.suite_kitchen}")
  end

  def kitchen_destroyed_correctly?
    system("kitchen destroy #{context_suite.suite_kitchen}")
  end

  def dirty_branch?
    `git status --porcelain`.split('\n').count > 0
  end

  def context_status
    JSON.parse(File.read(context_suite.status_file))[:status]
  end

  def kitchen_status
    JSON.parse(`kitchen list #{context_suite.suite_kitchen} --json`).detect{|suite| suite['instance'].include?(context_suite.suite_kitchen)}
  end

  def command_available?(context_name)
    system("knife #{context_name} knife context")
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
