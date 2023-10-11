
Alors('actionne {word} avec rake') do |rake_action|
  stop_test("L'action #{rake_action} à échouer", :rake_fail) unless system("rake #{rake_action}")
end
