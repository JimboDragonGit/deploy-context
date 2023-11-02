
Étantdonné('le plan {word}') do |habitat_plan|
  context_suite.plan_path = habitat_plan
  given_plan(context_suite)
end

Étantdonné('l\'organisation {word}') do |organisation_name|
  context_suite.organisation_name = organisation_name
end

Étantdonné('l\'application {word}') do |application_name|
  context_suite.application_name = application_name
end

Quand('le studio habitat est initialisé') do
  when_initialize_habitat(context_suite)
end

Quand('le secret {word} est disponible') do |secret_key|
  context_suite.secret_key = secret_key
  when_secret_available(context_suite)
end

Alors('construit selon le plan') do
  then_build_plan(context_suite)
end

Alors('démarre une tâche pour construire') do
  then_start_job(context_suite)
end

Quand('le projet est terminé') do
  when_project_end(context_suite)
end

Quand('le studio habitat réussi') do
  when_studio_success(context_suite)
end

Quand('une tâche est dispatché') do
  when_dispatch_job(context_suite)
end

Alors('attendre qu\'elle soit complété') do
  then_wait_completion(context_suite)
end

Alors('promouvoir la dite tâche') do
  then_promote_job(context_suite)
end

Quand('la dernière tâche diffère') do
  when_update_job(context_suite)
end

Quand('son status est Complete') do
  when_job_completed(context_suite)
end

Alors('enregistre le numéro de build') do
  write_build_id
end

Alors('nettoie le plan de travail') do
  then_clean_project(context_suite)
end

Alors('prépare le plan de travail') do
  # prepare_workplan
end

Alors('afficher les variables usagers') do
  generate_user_json
end
