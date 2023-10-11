
Étantdonné('le plan {word}') do |habitat_plan|
  context_suite.plan_path = habitat_plan
  stop_test("Habitat plan #{context_suite.plan_path} unavailable", :no_plan) unless Dir.exist?(context_suite.plan_path)
end

Quand('le studio habitat est initialisé') do
  stop_test("Habitat plan #{context_suite.plan_path} unavailable", :no_studio) unless verify_habitat?
end

Alors('construit selon le plan') do
  stop_test("Habitat plan #{context_suite.plan_path} unavailable", :build_fail) unless plan_build_successfully?
end

Quand('le projet est terminé') do
  stop_test("Le projet n'est pas compléter", :not_accepted) unless context_suite.status == :accepted
end

Quand('le studio habitat réussi') do
  stop_test("Le studio est un échec", context_suite.status) unless context_suite.status != :ok
end
