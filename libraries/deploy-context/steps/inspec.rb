
module Context
  module Steps
    module InspecSteps
      def install_inspector(context_suite)
        system("inspec habitat profile setup #{context_suite.habitat_name}")
      end

      def create_inspector(context_suite)
        system("inspec habitat profile create #{context_suite.habitat_name}")
      end

      def upload_inspector(context_suite)
        system("inspec habitat profile upload #{context_suite.habitat_name}")
      end

      def inspec_habitat(context_suite)
        system("inspec check #{context_suite.habitat_name}")
      end

      def exec_inspec_habitat(context_suite)
        system("inspec exec #{context_suite.habitat_name}")
      end

      def inspect_vendor(context_suite)
        system("inspec vendor --overwrite")
      end
    end
  end
end
