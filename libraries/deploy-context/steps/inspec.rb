
module Context
  module Steps
    module InspecSteps
      def install_inspector(context_suite)
        system("inspec habitat profile setup #{context_suite.spec_path}")
      end

      def create_inspector(context_suite)
        system("inspec habitat profile create #{context_suite.spec_path}")
      end

      def upload_inspector(context_suite)
        system("inspec habitat profile upload #{context_suite.spec_path}")
      end

      def inspec_habitat(context_suite)
        system("inspec check #{context_suite.spec_path}")
      end

      def exec_inspec_habitat(context_suite)
        inspec_cmd = %w(inspec exec) + [context_suite.spec_path]
        context_log "inspec_cmd = #{inspec_cmd}"
        system(inspec_cmd.join(' '))
      end

      def exec_inspec_habitat_with_help(context_suite)
        inspec_cmd = %w(inspec exec) + [context_suite.spec_path]
        inspec_cmd << ['--waiver-file', context_suite.waiver_file]
        inspec_cmd << ['--input-file', context_suite.input_file]
        system(inspec_cmd.join(' '))
      end

      def inspect_vendor(context_suite)
        oldpwd = Dir.pwd
        Dir.chdir context_suite.spec_path
        system("inspec vendor --overwrite")
        Dir.chdir oldpwd
      end
    end
  end
end
