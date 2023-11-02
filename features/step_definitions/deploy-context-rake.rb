
Alors('actionne {word} avec rake') do |rake_action|
  then_do_rake(rake_action)
end

Alors('bump la version') do
  then_bump_version
end

Alors('enregistre la version et la date') do
  then_save_version
end
