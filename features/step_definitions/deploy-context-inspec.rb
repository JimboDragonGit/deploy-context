
Étantdonné('l\'inspecteur d\'habitat {word}') do |spec_path|
  context_suite.spec_path = spec_path
  info_context_log "Given the inspector context_suite.spec_path", context_suite.spec_path
end

Alors('install l\'inspecteur d\'habitat {word}') do |spec_path|
  context_suite.spec_path = spec_path
  info_context_log "Then install the inspector context_suite.spec_path", context_suite.spec_path
  install_inspector(context_suite)
end

Alors('créer l\'inspecteur d\'habitat {word}') do |spec_path|
  context_suite.spec_path = spec_path
  info_context_log "Then create the inspector context_suite.spec_path", context_suite.spec_path
  create_inspector(context_suite)
end

Alors('charge l\'inspecteur d\'habitat {word}') do |spec_path|
  context_suite.spec_path = spec_path
  info_context_log "Then load the habitat for inspec context_suite.spec_path", context_suite.spec_path
  upload_inspector(context_suite)
end

Alors('inspecter l\'habitat {word}') do |spec_path|
  context_suite.spec_path = spec_path
  info_context_log "Then inspection the habitat context_suite.spec_path", context_suite.spec_path
  inspec_habitat(context_suite)
end

Alors('exécuter l\'inspection {word}') do |spec_path|
  context_suite.spec_path = spec_path
  info_context_log "Then start the inspection context_suite.spec_path", context_suite.spec_path
  exec_inspec_habitat(context_suite)
end

Alors('achète l\'inspecteur') do
  info_context_log "Then vendor the inspector context_suite.inspect", context_suite.inspect
  inspect_vendor(context_suite)
end
