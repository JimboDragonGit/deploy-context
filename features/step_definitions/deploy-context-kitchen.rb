# extend Context::Steps::Deploy

# deployer = Context::DeployContext.new(File.expand_path(__dir__, '../../'))

# define_steps(deployer)

Étantdonné('la suite kitchen {word}') do |kitchen_name|
  context_suite.suite_kitchen = kitchen_name
  context_suite.kitchen_name = kitchen_name
  given_kitchen(context_suite)
end

Quand('on initialise le projet') do
  when_intializing(context_suite)
end

Alors('converge la suite kitchen') do
  then_converge(context_suite)
end

Alors('vérify que le tout est OK') do
  then_check_ok(context_suite)
end

Alors('enregistre le statut {word}') do |status|
  update_status(status)
end

Quand('la suite kitchen est détruit') do
  when_destroy_kitchen(context_suite)
end

Quand('la suite kitchen est convergée') do
  when_converge_kitchen(context_suite)
end

Quand('la suite kitchen est vérifié') do
  when_validate_kitchen(context_suite)
end

Quand('la suite kitchen n\'est pas vérifié') do
  when_kitchen_fail(context_suite)
end

Alors('détruire la suite kitchen') do
  then_destroy_kitchen(context_suite)
end

Alors('vérifie la suite kitchen') do
  then_verify_kitchen(context_suite)
end

Alors('test la suite kitchen') do
  then_test_kitchen(context_suite)
end

Alors("nettoyer le fichiers vérouillés") do
  cookbook_clean(self)
end
