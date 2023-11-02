
module Context
  module Steps
    module SupermarketSteps
      def given_cookbook(context_suite)
        context_log "Installing cookbook #{context_suite.cookbook_to_install}"
      end

      def then_install_cookbook(context_suite)
        stop_test("Cookbook supermarket #{context_suite.cookbook_to_install} fail to share", :share_fail) unless system("knife supermarket share #{context_suite.cookbook_to_install} --cookbook-path ..")
      end
    end
  end
end
