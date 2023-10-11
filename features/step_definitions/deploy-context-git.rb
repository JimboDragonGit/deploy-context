
Étantdonné('la branche non maîtresse {word}') do |branch_name|
  context_suite.branch_name = branch_name
  stop_test("Git branch #{context_suite.branch_name} unavailable", :no_branch) unless branch_exist?
end

Quand('le dépot est brouillonné') do
  stop_test("Git branch #{context_suite.branch_name} is not dirty", :not_dirty) unless dirty_branch?
end

Quand('le dépot est propre') do
  stop_test("Git branch #{context_suite.branch_name} is dirty", :is_dirty) if dirty_branch?
end

Alors('note les modifications au dépot') do
  stop_test("Git branch #{context_suite.branch_name} modifications cannot be added", :git_add_issue) unless system('git add .')
end

Alors('interne les changements sur le dépot') do
  stop_test("Git branch #{context_suite.branch_name} commit issue", :commit_issue) unless git_commit_successfully?
end

Alors('fusionne le dépot avec la branche maîtresse') do
  stop_test("Git branch #{context_suite.branch_name} could't merge with master branch", :merge_issue) unless merge_to_master_successfull?
end

Étantdonné('la branche maîtresse') do
  stop_test("Issue switching to master", :master_switch_issue) unless system('git checkout master')
end

Alors('déploi les modifications') do
  stop_test("Le déploiment vers son origine lointaine à échouer", :git_push_issue) unless system('git push')
end

Alors('va sur la branche non maîtresse {word}') do |branch_name|
  context_suite.branch_name = branch_name
  stop_test("Le déploiment vers son origine lointaine à échouer", :git_checkout_issue) unless switch_branch_successful?
end

Alors('récupère les dernières modifications') do
  stop_test("Le récupération avec son origine lointaine à échouer", :git_pull_issue) unless ystem('git pull')
end
