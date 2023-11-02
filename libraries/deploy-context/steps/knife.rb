
module Context
  module Steps
    module KnifeSteps
      def when_list_cookbooks
        stop_test('knife n\'est pas disponible, veuillez installer Chef Workstation', :no_knife) unless system('knife cookbook list')
      end

      def when_knife_available(sub_knife)
        stop_test("le couteau #{sub_knife} n\'est pas disponible", :no_sub_knife) unless command_available?(sub_knife, 'knife context')
      end

      def given_knife(context_suite)
        stop_test("Le couteau #{context_suite.knife_name} n\'est pas disponible", :no_context_knife) unless command_available?(context_suite.knife_context, 'knife context')
      end

      def then_show_help(context_suite)
        # stop_test("le couteau #{context_suite.knife_context} ne peux afficher son aide", :no_sub_help) unless
        system("knife #{context_suite.knife_context} #{context_suite.knife_command} --help")
      end

      def then_publish_cookbook(cookbook_name)
        stop_test("le couteau ne peux publier le cookbook #{cookbook_name}", :cookbook_publish_fail) unless system("knife cookbook upload #{cookbook_name}")
      end

      def then_deploy_cookbook(cookbook_name)
        stop_test("chef ne peut déployer le cookbook #{cookbook_name}", :cookbook_deploy_fail) unless cookbook_push(self)
      end

      def then_autopublish_cookbook(cookbook_name)
        stop_test("le couteau ne peux publier le cookbook #{cookbook_name}", :cookbook_autopublish_fail) unless system("knife cookbook upload #{cookbook_name} --cookbook-path #{::File.dirname(Dir.pwd)}")
      end

      def then_execute_knife_command(context_suite)
        stop_test("le couteau #{context_suite.knife_context} ne peux executer la commande #{context_suite.knife_command}", :sub_knife_issue) unless system("knife #{context_suite.knife_context} #{context_suite.knife_command}")
      end

      def then_execute_sub_knife_command(context_suite)
        stop_test("le couteau #{context_suite.knife_context} ne peux executer la commande #{context_suite.knife_command} #{context_suite.sub_knife_command}", :sub_knife_issue) unless system("knife #{context_suite.knife_context} #{context_suite.knife_command} #{context_suite.sub_knife_command}")
      end
    end
  end
end
