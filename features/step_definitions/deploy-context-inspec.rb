
Étantdonné('l\'inspecteur d\'habitat {word}') do |spec_path|
  context_suite.spec_path = spec_path
end

Alors('install l\'inspecteur d\'habitat {word}') do |spec_path|
  context_suite.spec_path = spec_path
  install_inspector(context_suite)
end

Alors('créer l\'inspecteur d\'habitat {word}') do |spec_path|
  context_suite.spec_path = spec_path
  create_inspector(context_suite)
end

Alors('charge l\'inspecteur d\'habitat {word}') do |spec_path|
  context_suite.spec_path = spec_path
  upload_inspector(context_suite)
end

Alors('inspecter l\'habitat {word}') do |spec_path|
  context_suite.spec_path = spec_path
  inspec_habitat(context_suite)
end

Alors('exécuter l\'inspection {word}') do |spec_path|
  context_suite.spec_path = spec_path
  exec_inspec_habitat(context_suite)
end

Alors('achète l\'inspecteur') do
  inspect_vendor(context_suite)
end
