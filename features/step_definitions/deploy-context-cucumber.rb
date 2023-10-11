
Étantdonné('la suite de test {word}') do |test_suite|
  context_suite.test_suite = test_suite
  stop_test("Cucumber #{context_suite.test_suite} is unavailable", :no_cucumber) unless system("cucumber -d")
end

Quand('les tests sont réussi') do
  stop_test("Cucumber test #{context_suite.test_suite} failed on execution", :cucumber_test_issue) unless system("knife context deploy --context-name #{context_suite.test_suite}")
end
