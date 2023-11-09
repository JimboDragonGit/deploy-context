# extend Context::Steps::Deploy

# deployer = Context::DeployContext.new(File.expand_path(__dir__, '../../'))

# define_steps(deployer)

Étantdonné('la suite kitchen {word}') do |kitchen_name|
  context_suite.suite_kitchen = kitchen_name
  context_suite.kitchen_name = kitchen_name
  info_context_log "Given kitchen name context_suite.suite_kitchen", context_suite.suite_kitchen
  info_context_log "Given kitchen name context_suite.kitchen_name", context_suite.kitchen_name
  given_kitchen(context_suite)
end

Quand('on initialise le projet') do
  info_context_log "Then initialize the project context_suite.inspect", context_suite.inspect
  when_intializing(context_suite)
end

Alors('converge la suite kitchen') do
  info_context_log "Then converge kitchen context_suite.inspect", context_suite.inspect
  then_converge(context_suite)
end

Alors('vérify que le tout est OK') do
  info_context_log "Then check that all is ok context_suite.inspect", context_suite.inspect
  then_check_ok(context_suite)
end

Alors('enregistre le statut {word}') do |status|
  context_suite.status = status
  info_context_log "Then save status context_suite.status", context_suite.status
  update_status(context_suite.status)
end

Quand('la suite kitchen est détruit') do
  info_context_log "When kitchen is destroyed context_suite.inspect", context_suite.inspect
  when_destroy_kitchen(context_suite)
end

Quand('la suite kitchen est convergée') do
  info_context_log "When kitchen is converged context_suite.inspect", context_suite.inspect
  when_converge_kitchen(context_suite)
end

Quand('la suite kitchen est vérifié') do
  info_context_log "When kitchen is verified context_suite.inspect", context_suite.inspect
  when_validate_kitchen(context_suite)
end

Quand('la suite kitchen n\'est pas vérifié') do
  info_context_log "When kitchen not verified context_suite.inspect", context_suite.inspect
  when_kitchen_fail(context_suite)
end

Alors('détruire la suite kitchen') do
  info_context_log "Then destroy kitchen context_suite.inspect", context_suite.inspect
  then_destroy_kitchen(context_suite)
end

Alors('vérifie la suite kitchen') do
  info_context_log "Then verify kitchen context_suite.inspect", context_suite.inspect
  then_verify_kitchen(context_suite)
end

Alors('test la suite kitchen') do
  info_context_log "Then test kitchen context_suite.inspect", context_suite.inspect
  then_test_kitchen(context_suite)
end

Alors("nettoyer les fichiers vérouillés") do
  info_context_log "Then clean locked files context_suite.inspect", context_suite.inspect
  cookbook_clean(context_suite)
  ruby_clean(context_suite)
end

Alors('enregistre le data bag usager {word}') do |context_user|
  context_suite.context_user = context_user
  context_suite.kitchen_user = ENV['KITCHEN_USER']
  info_context_log "Then save data bag context_suite.context_user", context_suite.context_user
  info_context_log "Then save data bag context_suite.kitchen_user", context_suite.kitchen_user
  set_users_databags(context_suite)
end
