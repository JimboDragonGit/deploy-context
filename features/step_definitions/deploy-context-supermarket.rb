
Étantdonné('le cookbook {word}') do |cookbook_to_install|
  context_suite.cookbook_to_install = cookbook_to_install
  info_context_log "Given cookbook context_suite.cookbook_to_install", context_suite.cookbook_to_install
  given_cookbook(context_suite)
end

Alors('partager le cookbook {word}') do |cookbook_to_install|
  context_suite.cookbook_to_install = cookbook_to_install
  info_context_log "Then share cookbook context_suite.cookbook_to_install", context_suite.cookbook_to_install
  then_install_cookbook(context_suite)
end
