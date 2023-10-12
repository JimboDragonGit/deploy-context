
Alors('actionne {word} avec rake') do |rake_action|
  stop_test("L'action #{rake_action} à échouer", :rake_fail) unless system("rake #{rake_action}")
end

Alors('bump la version') do
  stop_test("Bumper la version a échoué", :rake_bump_fail) unless true # system("git git-version-bump patch")
end

Alors('enregistre la version et la date') do
  stop_test("Bumper la version a échoué", :rake_bump_fail) unless true # system("git git-version-bump patch")
end
