def context_exec(command)
  system(command.join(' '))
end

# Étantdonnéque('le projet {word} à une dernière version de disponible dans git') do |project_name|
#   context_exec [project_name, 'once']
  
#   if project_name == deployer.context_name
#     Dir.chdir deployer.context_folder
#   else
#     Dir.chdir File.join(deployer.contexts_container(deployer), project_name)
#   end
# end

Alors('démarrer un simple cycle de {word}') do |project_name|
  context_exec [project_name, 'once'] || abort!('Issue with life cycle')
end

Alors('déployer le projet {word}') do |project_name|
  context_exec [project_name, 'release'] || abort!('Issue with deploy steps')
end

Alors('tester le projet {word}') do |project_name|
  context_exec [project_name, 'test'] || abort!('Issue with testing steps')
end

Étantdonnéque('le projet {word} à du code à updater') do |project_name|
  context_exec [project_name, 'check_code_to_update'] || abort!('Issue to check updated code')
end

Alors('bumper la version du patch de {word}') do |project_name|
  context_exec [project_name, 'bump'] || abort!('Issue with bumping version')
end

Étantdonnéque('le projet {word} à la bonne version d\'installer') do |project_name|
  context_exec [project_name, 'check_installed_version'] || abort!('Issue to check installed version')
end

Étantdonnéque('le projet {word} à une nouvelle version de disponible') do |project_name|
  context_exec [project_name, 'check_new_version'] || abort!('Issue to check newer version available')
end

