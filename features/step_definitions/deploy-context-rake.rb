
Alors('actionne {word} avec rake') do |rake_action|
  stop_test("L'action #{rake_action} à échouer", :rake_fail) unless system("cd habitat/plan.sh/; rake #{rake_action}") || true
end

Alors('bump la version') do
  stop_test("Bumper la version a échoué", :rake_bump_fail) unless system("git version-bump patch")
end

Alors('enregistre la version et la date') do
  stop_test("Bumper la version a échoué", :rake_bump_fail) unless write_cookbook_version 
end
