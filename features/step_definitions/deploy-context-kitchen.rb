# extend Context::Steps::Deploy

# deployer = Context::DeployContext.new(File.expand_path(__dir__, '../../'))

# define_steps(deployer)

Étantdonné('la suite kitchen {word}') do |kitchen_name|
  context_suite.suite_kitchen = kitchen_name
  stop_test("Kitchen suite #{kitchen_name} unavailable", :no_kitchen) unless kitchen_suite_exist?
end

Quand('on initialise le projet') do
  stop_test('Le projet est déjà initialisé', :already_initialized) if File.exist?(context_suite.status_file) && context_suite.status != :initialisation_fail
end

Alors('converge la suite kitchen') do
  stop_test("la suite kitchen #{context_suite.suite_kitchen} est en échec", :converge_fail) unless kitchen_converged_successfully?
end

Alors('vérify que le tout est OK') do
  context_suite.status = if verify_kitchen? && verify_habitat?
    :ok
  else
    :not_all_ok
  end
  stop_test("la suite kitchen #{context_suite.suite_kitchen} est en échec", context_suite.status) if context_suite.status == :initialisation_fail
end

Alors('enregistre le statut {word}') do |status|
  update_status(status)
end

Quand('la suite kitchen est vérifié') do
  verify_kitchen_status
  stop_test("La suite #{context_suite.suite_kitchen} n'est pas vérifié", context_suite.status) if context_suite.status == :verification_fail
end

Quand('la suite kitchen n\'est pas vérifié') do
  verify_kitchen_status
  stop_test("La suite #{context_suite.suite_kitchen} est vérifié", context_suite.status) unless context_suite.status != :verified
end

Alors('détruire la suite kitchen') do
  stop_test("Kitchen suite #{context_suite.kitchen_suite} destruction failed", :no_kitchen) unless kitchen_destroyed_correctly?
end

Alors('vérifie la suite kitchen') do
  stop_test("Kitchen suite #{context_suite.kitchen_suite} verification failed", :verify_kitchen_failed) unless verify_kitchen?
end

Alors('test la suite kitchen') do
  stop_test("Kitchen suite #{context_suite.kitchen_suite} test failed", :test_kitchen_failed) unless kitchen_tested_successfully?
end
