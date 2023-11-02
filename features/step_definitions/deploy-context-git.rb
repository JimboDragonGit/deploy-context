
Étantdonné('la branche non maîtresse {word}') do |branch_name|
  context_suite.branch_name = branch_name
  given_branch(context_suite)
end

Quand('le dépot est brouillonné') do
  when_dirty_branch(context_suite)
end

Quand('le dépot est propre') do
  when_clean_branch(context_suite)
end

Alors('note les modifications au dépot') do
  then_add_modification(context_suite)
end

Alors('interne les changements sur le dépot') do
  then_commit_internal(context_suite)
end

Alors('fusionne le dépot avec la branche {word}') do |branch_name|
  context_suite.branch_name = branch_name
  then_merge_branch(context_suite)
end

Étantdonné('la branche maîtresse') do
  context_suite.branch_name = 'master'
  given_master_branch(context_suite)
end

Alors('déploi les courantes modifications') do
  then_push_git(context_suite)
end

Alors('déploi les modifications de la branche {word}') do |branch_name|
  context_suite.branch_name = branch_name
  then_push_branch(context_suite, branch_name)
end

Alors('va sur la branche non maîtresse {word}') do |branch_name|
  context_suite.branch_name = branch_name
  then_checkout_branch(context_suite, branch_name)
end

Alors('récupère les dernières modifications') do
  then_pull_origin
end

Alors('supprime le fichier de status') do
  delete_status_file(context_suite)
end
