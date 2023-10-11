
Quand('on peut lister les cookbooks') do
  stop_test('knife n\'est pas disponible, veuillez installer Chef Workstation', :no_knife) unless system('knife cookbook list')
end

Quand('un couteau {word} est accessible') do |sub_knife|
  stop_test("le couteau #{sub_knife} n\'est pas disponible", :no_sub_knife) unless command_available?(sub_knife)
end

Étantdonnéque('le couteau {word}') do |context_name|
  context_suite.knife_context = context_name
  stop_test("Le couteau #{context_name} n\'est pas disponible", :no_context_knife) unless command_available?(context_name)
end

Alors('je peux affiché l\'aide du couteau') do
  stop_test("le couteau #{sub_knife} ne peux afficher son aide", :no_sub_help) unless system("knife #{context_suite.knife_context} --help")
end
