
module Context
  module Steps
    module RubySteps
      def given_gem(context_suite)
        context_log "Installing #{context_suite.gem_to_install}"
      end

      def then_install_gem(context_suite)
        stop_test("Gem #{context_suite.gem_to_install} fail to install", :install_fail) unless system("gem install #{context_suite.gem_to_install}")
      end

      def then_show_install_folder(context_suite)
        stop_test("Gem #{context_suite.gem_to_install} fail to show install folder", :install_fail) unless system("find #{::File.join(ENV['HOME'], '.chef')} -type d -name #{context_suite.gem_to_install} -exec echo show {} \\; -exec ls -alh {} \\;")
      end
    end
  end
end
