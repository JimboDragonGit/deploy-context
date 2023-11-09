
Étantdonné('l\'idée {word}') do |idea|
  context_suite.idea = idea
end

Étantdonné('le fichier de pardon {word}') do |waiver_file|
  context_suite.waiver_file = waiver_file
end

Étantdonné('le fichier d\'entré {word}') do |input_file|
  context_suite.input_file = input_file
end

Quand('démaré l\'habitat d\'inspection {word}') do |spec_path|
  context_suite.spec_path = spec_path
  inspec_habitat(context_suite)
end

Quand('démarré l\'habitat de cuisine {word}') do |spec_path|
  context_suite.spec_path = spec_path
  inspec_habitat(context_suite)
end

Alors('avec l\'aide de {word} et les données {word}, exécuter l\'inspection {word}') do |waiver_file, input_file, spec_path|
  context_suite.spec_path = spec_path
  context_suite.waiver_file = waiver_file
  context_suite.input_file = input_file
  exec_inspec_habitat_with_help(context_suite)
end

Quand('le rapport {word} a atteint {int} succès') do |rapport_name, require_inspec_success|
  context_suite.rapport_name = rapport_name
  context_suite.require_inspec_success = require_inspec_success
  when_report_succeeded(context_suite)
end

Alors('écrire la prochaine version') do
  pending # Write code here that turns the phrase above into concrete actions
end
