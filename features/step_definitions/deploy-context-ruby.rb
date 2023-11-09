
Étantdonné('le gem {word}') do |gem_to_install|
  context_suite.gem_to_install = gem_to_install
  info_context_log "Given gem context_suite.gem_to_install", context_suite.gem_to_install
  given_gem(context_suite)
end

Alors('installer le gem {word}') do |gem_to_install|
  context_suite.gem_to_install = gem_to_install
  info_context_log "Then install gem context_suite.gem_to_install", context_suite.gem_to_install
  then_install_gem(context_suite)
end

Alors('vérifier le répertoire d\'installation') do
  info_context_log "Validate installation folder context_suite.inspect", context_suite.inspect
  then_show_install_folder(context_suite)
end
