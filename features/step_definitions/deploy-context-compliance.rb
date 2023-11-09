
Étantdonné('l\'idée {word}') do |idea|
  context_suite.idea = idea
  info_context_log "With idea context_suite.idea", context_suite.idea
end

Étantdonné('le fichier de pardon {word}') do |waiver_file|
  context_suite.waiver_file = waiver_file
  info_context_log "With waiver file context_suite.waiver_file", context_suite.waiver_file
end

Étantdonné('le fichier d\'entré {word}') do |input_file|
  context_suite.input_file = input_file
  info_context_log "With input file context_suite.input_file", context_suite.input_file
end

Quand('démaré l\'habitat d\'inspection {word}') do |spec_path|
  context_suite.spec_path = spec_path
  context_suite.plan_path = plan_path
  info_context_log "When start inspection context_suite.spec_path", context_suite.spec_path
  info_context_log "When start inspection context_suite.plan_path", context_suite.plan_path
  inspec_habitat(context_suite)
end

Quand('démarré l\'habitat de cuisine {word}') do |spec_path|
  context_suite.spec_path = spec_path
  context_suite.plan_path = plan_path
  info_context_log "When start habitat context_suite.spec_path", context_suite.spec_path
  info_context_log "When start habitat context_suite.plan_path", context_suite.plan_path
  inspec_habitat(context_suite)
end

Alors('avec l\'aide de {word} et les données {word}, exécuter l\'inspection {word}') do |waiver_file, input_file, spec_path|
  context_suite.spec_path = spec_path
  context_suite.waiver_file = waiver_file
  context_suite.input_file = input_file
  info_context_log "Then with help context_suite.spec_path", context_suite.spec_path
  info_context_log "Then with help context_suite.plan_path", context_suite.plan_path
  info_context_log "Then with help context_suite.waiver_file", context_suite.waiver_file
  info_context_log "Then with help context_suite.input_file", context_suite.input_file
  exec_inspec_habitat_with_help(context_suite)
end

Quand('le rapport {word} a atteint {int} succès') do |rapport_name, require_inspec_success|
  context_suite.rapport_name = rapport_name
  context_suite.require_inspec_success = require_inspec_success
  info_context_log "When report succeed context_suite.spec_path", context_suite.spec_path
  info_context_log "When report succeed context_suite.plan_path", context_suite.plan_path
  info_context_log "When report succeed context_suite.waiver_file", context_suite.waiver_file
  info_context_log "When report succeed context_suite.input_file", context_suite.input_file
  info_context_log "When report succeed context_suite.rapport_name", context_suite.rapport_name
  info_context_log "When report succeed context_suite.require_inspec_success", context_suite.require_inspec_success
  when_report_succeeded(context_suite)
end

Alors('écrire la prochaine version') do
  info_context_log "Then write the new version", context_suite.spec_path
  pending # Write code here that turns the phrase above into concrete actions
end
