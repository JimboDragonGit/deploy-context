
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
  stop_test("Git branch #{context_suite.branch_name} modifications cannot be added", :commit_issue) unless system('git add .')
end

Alors('interne les changements sur le dépot') do
  stop_test("Git branch #{context_suite.branch_name} commit issue", :commit_issue) unless git_commit_successfully?
end

Alors('fusionne le dépot avec la branche maîtresse') do
  pending # Write code here that turns the phrase above into concrete actions
end
