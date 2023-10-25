
Quand('on peut lister les cookbooks') do
  stop_test('knife n\'est pas disponible, veuillez installer Chef Workstation', :no_knife) unless system('knife cookbook list')
end

Quand('un couteau {word} est accessible') do |sub_knife|
  stop_test("le couteau #{sub_knife} n\'est pas disponible", :no_sub_knife) unless command_available?(sub_knife, 'knife context')
end

Étantdonnéque('le couteau {word}') do |knife_name|
  context_suite.knife_context = knife_name
  stop_test("Le couteau #{knife_name} n\'est pas disponible", :no_context_knife) unless command_available?(context_suite.knife_context, 'knife context')
end

Alors('je peux affiché l\'aide du couteau') do
  # stop_test("le couteau #{context_suite.knife_context} ne peux afficher son aide", :no_sub_help) unless
  system("knife #{context_suite.knife_context} #{context_suite.knife_command} --help")
end

Alors('publier le cookbook {word}') do |cookbook_name|
  stop_test("le couteau ne peux publier le cookbook #{cookbook_name}", :cookbook_publish_fail) unless system("knife cookbook upload #{cookbook_name}")
end

Alors('autodéployer le cookbook {word}') do |cookbook_name|
  stop_test("chef ne peut déployer le cookbook #{cookbook_name}", :cookbook_deploy_fail) unless cookbook_push(self)
end

Alors('autopublier le cookbook {word}') do |cookbook_name|
  stop_test("le couteau ne peux publier le cookbook #{cookbook_name}", :cookbook_autopublish_fail) unless system("knife cookbook upload #{cookbook_name} --cookbook-path #{::File.dirname(Dir.pwd)}")
end

Étantdonné('la commande couteau {word}') do |knife_command|
  context_suite.knife_command = knife_command
end

Alors('exécute la commande couteau {word}') do |knife_command|
  context_suite.knife_command = knife_command
  stop_test("le couteau #{context_suite.knife_context} ne peux executer la commande #{context_suite.knife_command}", :sub_knife_issue) unless system("knife #{context_suite.knife_context} #{context_suite.knife_command}")
end

Alors('exécute la sous commande couteau {word} {word}') do |knife_command, sub_knife_command|
  context_suite.knife_command = knife_command
  context_suite.sub_knife_command = sub_knife_command
  stop_test("le couteau #{context_suite.knife_context} ne peux executer la commande #{context_suite.knife_command} #{context_suite.sub_knife_command}", :sub_knife_issue) unless system("knife #{context_suite.knife_context} #{context_suite.knife_command} #{context_suite.sub_knife_command}")
end
