
Alors('actionne {word} avec rake') do |rake_action|
  context_suite.rake_action = rake_action
  info_context_log "Then activate rake action context_suite.rake_action", context_suite.rake_action
  then_do_rake(context_suite.rake_action)
end

Alors('bump la version') do
  info_context_log "Then bump version context_suite.inspect", context_suite.inspect
  then_bump_version
end

Alors('enregistre la version et la date') do
  info_context_log "Then save version and date context_suite.inspect", context_suite.inspect
  then_save_version
end
