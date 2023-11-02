
Étantdonné('l\'inspecteur d\'habitat {word}') do |habitat_name|
  context_suite.habitat_name = habitat_name
end

Alors('install l\'inspecteur d\'habitat {word}') do |habitat_name|
  context_suite.habitat_name = habitat_name
  install_inspector(context_suite)
end

Alors('créer l\'inspecteur d\'habitat {word}') do |habitat_name|
  context_suite.habitat_name = habitat_name
  create_inspector(context_suite)
end

Alors('charge l\'inspecteur d\'habitat {word}') do |habitat_name|
  context_suite.habitat_name = habitat_name
  upload_inspector(context_suite)
end

Alors('inspecter l\'habitat {word}') do |habitat_name|
  context_suite.habitat_name = habitat_name
  inspec_habitat(context_suite)
end

Alors('exécuter l\'inspection {word}') do |habitat_name|
  context_suite.habitat_name = habitat_name
  exec_inspec_habitat(context_suite)
end
