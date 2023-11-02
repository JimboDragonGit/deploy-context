
module Context
  module Steps
    module RubySteps
      def given_gem(context_suite)
        context_log "Installing #{context_suite.gem_to_install}"
      end

      def then_install_gem(context_suite)
        stop_test("Gem #{context_suite.gem_to_install} fail to install", :install_fail) unless system("gem install #{context_suite.gem_to_install}")
      end
    end
  end
end
