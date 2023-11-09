
Étantdonné('la suite de test {word}') do |test_suite|
  context_suite.test_suite = test_suite
  info_context_log "Given test context_suite.test_suite", context_suite.test_suite
  given_test_suite(context_suite)
end

Quand('les tests sont réussi') do
  info_context_log "All test successfull context_suite.inspect", context_suite.inspect
  test_successfull?(context_suite)
end

Étantdonné('le profile {word}') do |profile_name|
  context_suite.profile_name = profile_name
  info_context_log "Given profile context_suite.profile_name", context_suite.profile_name
  given_profile_name(context_suite)
end

Alors('émettre le rapport') do
  info_context_log "Then create report context_suite.inspect", context_suite.inspect
  report_the_report(context_suite)
end
