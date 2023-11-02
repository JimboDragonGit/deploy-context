
Étantdonné('la suite de test {word}') do |test_suite|
  context_suite.test_suite = test_suite
  given_test_suite(context_suite)
end

Quand('les tests sont réussi') do
  test_successfull?(context_suite)
end

Étantdonné('le profile {word}') do |profile_name|
  context_suite.profile_name = profile_name
  given_profile_name(context_suite)
end

Alors('émettre le rapport') do
  report_the_report(context_suite)
end
