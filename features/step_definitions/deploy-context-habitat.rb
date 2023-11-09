
Étantdonné('le plan {word}') do |habitat_plan|
  context_suite.plan_path = habitat_plan
  info_context_log "Given the plan context_suite.plan_path", context_suite.plan_path
  given_plan(context_suite)
end

Étantdonné('l\'organisation {word}') do |organisation_name|
  context_suite.organisation_name = organisation_name
  info_context_log "Given the organisation context_suite.organisation_name", context_suite.organisation_name
end

Étantdonné('l\'application {word}') do |application_name|
  context_suite.application_name = application_name
  info_context_log "Given the application context_suite.application_name", context_suite.application_name
end

Quand('le studio habitat est initialisé') do
  info_context_log "When the habitat is initialized context_suite.inspect", context_suite.inspect
  when_initialize_habitat(context_suite)
end

Quand('le secret {word} est disponible') do |secret_key|
  context_suite.secret_key = secret_key
  info_context_log "When the secret is available context_suite.secret_key", context_suite.secret_key
  when_secret_available(context_suite)
end

Alors('construit selon le plan') do
  info_context_log "Then build as per plan context_suite.inspect", context_suite.inspect
  then_build_plan(context_suite)
end

Alors('démarre une tâche pour construire') do
  info_context_log "Then start a build process context_suite.inspect", context_suite.inspect
  then_start_job(context_suite)
end

Quand('le projet est terminé') do
  info_context_log "When a project is ended context_suite.inspect", context_suite.inspect
  when_project_end(context_suite)
end

Quand('le studio habitat réussi') do
  info_context_log "When a habitat stdio buiild is successfull context_suite.inspect", context_suite.inspect
  when_studio_success(context_suite)
end

Quand('une tâche est dispatché') do
  info_context_log "When a habitat job is disptched context_suite.inspect", context_suite.inspect
  when_dispatch_job(context_suite)
end

Alors('attendre qu\'elle soit complété') do
  info_context_log "Then wait for habitat job completion context_suite.inspect", context_suite.inspect
  then_wait_completion(context_suite)
end

Alors('promouvoir la dite tâche') do
  info_context_log "Then promote habitat job context_suite.inspect", context_suite.inspect
  then_promote_job(context_suite)
end

Quand('la dernière tâche diffère') do
  info_context_log "When last task is different context_suite.inspect", context_suite.inspect
  when_update_job(context_suite)
end

Quand('son status est Complete') do
  info_context_log "When job completed context_suite.inspect", context_suite.inspect
  when_job_completed(context_suite)
end

Alors('enregistre le numéro de build') do
  info_context_log "Then save the build id context_suite.inspect", context_suite.inspect
  write_build_id
end

Alors('nettoie le plan de travail') do
  info_context_log "Then clean the workspace context_suite.inspect", context_suite.inspect
  then_clean_project(context_suite)
end

Alors('prépare le plan de travail') do
  info_context_log "Then prepare the workspace context_suite.inspect", context_suite.inspect
  # prepare_workplan
end

Alors('afficher les variables usagers') do
  info_context_log "Then generate json for the user context_suite.inspect", context_suite.inspect
  generate_user_json
end

Alors('enregistre le secret {word}') do |secret_key|
  context_suite.secret_key = secret_key
  info_context_log "Then save secret context_suite.secret_key", context_suite.secret_key
  then_set_secret(context_suite)
end
