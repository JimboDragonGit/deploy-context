
Quand('on peut lister les cookbooks') do
  when_list_cookbooks
end

Quand('un couteau {word} est accessible') do |sub_knife|
  when_knife_available(sub_knife)
end

Étantdonnéque('le couteau {word}') do |knife_name|
  context_suite.knife_context = knife_name
  context_suite.knife_name = knife_name
  info_context_log "Given knife name context_suite.knife_context", context_suite.knife_context
  info_context_log "Given knife name context_suite.knife_name", context_suite.knife_name
  given_knife(context_suite)
end

Alors('je peux affiché l\'aide du couteau') do
  info_context_log "Then show help context_suite.inspect", context_suite.inspect
  then_show_help(context_suite)
end

Alors('publier le cookbook {word}') do |cookbook_name|
  context_suite.cookbook_name = cookbook_name
  info_context_log "Then publish context_suite.cookbook_name", context_suite.cookbook_name
  then_publish_cookbook(context_suite.cookbook_name)
end

Alors('autodéployer le cookbook {word}') do |cookbook_name|
  context_suite.cookbook_name = cookbook_name
  info_context_log "Then auto deploy context_suite.cookbook_name", context_suite.cookbook_name
  then_deploy_cookbook(context_suite.cookbook_name)
end

Alors('autopublier le cookbook {word}') do |cookbook_name|
  context_suite.cookbook_name = cookbook_name
  info_context_log "Then auto publish context_suite.cookbook_name", context_suite.cookbook_name
  then_autopublish_cookbook(context_suite.cookbook_name)
end

Étantdonné('la commande couteau {word}') do |knife_command|
  context_suite.knife_command = knife_command
  info_context_log "Given knife command context_suite.knife_command", context_suite.knife_command
end

Alors('exécute la commande couteau {word}') do |knife_command|
  context_suite.knife_command = knife_command
  info_context_log "Then execute knife command context_suite.knife_command", context_suite.knife_command
  then_execute_knife_command(context_suite)
end

Alors('exécute la sous commande couteau {word} {word}') do |knife_command, sub_knife_command|
  context_suite.knife_command = knife_command
  context_suite.sub_knife_command = sub_knife_command
  info_context_log "Then execute knife sub command context_suite.knife_command", context_suite.knife_command
  info_context_log "Then execute knife sub command context_suite.sub_knife_command", context_suite.sub_knife_command
  then_execute_sub_knife_command(context_suite)
end
