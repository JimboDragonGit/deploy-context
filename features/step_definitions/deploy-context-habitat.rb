
Étantdonné('le plan {word}') do |habitat_plan|
  context_suite.plan_path = habitat_plan
  stop_test("Habitat plan #{context_suite.plan_path} unavailable", :no_plan) unless Dir.exist?(context_suite.plan_path)
end

Étantdonné('l\'organisation {word}') do |organisation_name|
  context_suite.organisation_name = organisation_name
end

Étantdonné('l\'application {word}') do |application_name|
  context_suite.application_name = application_name
end

Quand('le studio habitat est initialisé') do
  stop_test("Habitat plan #{context_suite.plan_path} unavailable", :no_studio) unless verify_habitat?
end

Alors('construit selon le plan') do
  stop_test("Habitat plan #{context_suite.plan_path} unavailable", :build_fail) unless plan_build_successfully?
end

Alors('démarre une tâche pour construire') do
  stop_test("Habitat plan builder #{context_suite.plan_path} failed", :builder_fail) unless system("hab bldr job start #{context_suite.organisation_name}/#{context_suite.application_name} x86_64-linux")
end

Quand('le projet est terminé') do
  stop_test("Le projet n'est pas compléter", :not_accepted) unless context_suite.status == :accepted
end

Quand('le studio habitat réussi') do
  stop_test("Le studio est un échec", context_suite.status) unless context_suite.status != :ok
end

Quand('une tâche est dispatché') do
  stop_test("Aucun tâche de disponible sur l'origin #{context_suite.organisation_name}", :no_habitat_task_dispatched) unless habitat_new_task?
end

Alors('attendre qu\'elle soit complété') do
  second_pass = 0
  while true do
    if habitat_new_task?
      puts "Waiting for task... #{second_pass} seconds"
      sleep 1
      second_pass += 1
    else
      break
    end
  end
end

Alors('promouvoir la dite tâche') do
  stop_test("Promouvoir la tâche sur l'origin #{context_suite.organisation_name}", :habitat_promotion_fail) unless habitat_task_completed?
end

Quand('la dernière tâche diffère') do
  stop_test("Même tâche que son origin #{context_suite.organisation_name}", :same_last_build) unless habitat_task_different?
end

Quand('son status est Complete') do
  stop_test("Même tâche que son origin #{context_suite.organisation_name}", :same_last_build) unless habitat_task_completed?
end

Alors('enregistre le numéro de build') do
  write_build_id
end

Alors('nettoie le plan de travail') do
  delete_file_only_if_exist(get_context_file(self, 'habitat/plan.sh/Gemfile.lock'))
end

Alors('prépare le plan de travail') do
  prepare_workplan
end
