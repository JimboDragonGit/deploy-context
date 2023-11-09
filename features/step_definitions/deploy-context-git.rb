
Étantdonné('la branche non maîtresse {word}') do |branch_name|
  context_suite.branch_name = branch_name
  info_context_log "Given branch context_suite.branch_name", context_suite.branch_name
  given_branch(context_suite)
end

Quand('le dépot est brouillonné') do
  info_context_log "When repo is not clean context_suite.inspect", context_suite.inspect
  when_dirty_branch(context_suite)
end

Quand('le dépot est propre') do
  info_context_log "When repo is clean context_suite.inspect", context_suite.inspect
  when_clean_branch(context_suite)
end

Alors('note les modifications au dépot') do
  info_context_log "Then add new content context_suite.inspect", context_suite.inspect
  then_add_modification(context_suite)
end

Alors('interne les changements sur le dépot') do
  info_context_log "Then commit content context_suite.inspect", context_suite.inspect
  then_commit_internal(context_suite)
end

Alors('fusionne le dépot avec la branche {word}') do |branch_name|
  context_suite.branch_name = branch_name
  info_context_log "Then merge content context_suite.branch_name", context_suite.branch_name
  then_merge_branch(context_suite)
end

Étantdonné('la branche maîtresse') do
  context_suite.branch_name = 'master'
  info_context_log "Given master branch context_suite.branch_name", context_suite.branch_name
  given_master_branch(context_suite)
end

Alors('déploi les courantes modifications') do
  info_context_log "Then publish modifications context_suite.inspect", context_suite.inspect
  then_push_git(context_suite)
end

Alors('déploi les modifications de la branche {word}') do |branch_name|
  context_suite.branch_name = branch_name
  info_context_log "Then push branch context_suite.branch_name", context_suite.branch_name
  then_push_branch(context_suite)
end

Alors('va sur la branche non maîtresse {word}') do |branch_name|
  context_suite.branch_name = branch_name
  info_context_log "Then go on branch context_suite.branch_name", context_suite.branch_name
  then_checkout_branch(context_suite)
end

Alors('récupère les dernières modifications') do
  info_context_log "Then pull lastest code context_suite.inspect", context_suite.inspect
  then_pull_origin
end

Alors('supprime le fichier de status') do
  info_context_log "Then delete status file context_suite.inspect", context_suite.inspect
  delete_status_file(context_suite)
end
