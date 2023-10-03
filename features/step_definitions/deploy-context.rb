Étantdonné('le projet {string}') do |project_name|
  if project_name == deployer.context_name
    Dir.chdir deployer.context_folder
  else
    Dir.chdir deployer.get_context_folder(project_name)
  end
end

Alors('démarrer un simple cycle de {string}') do |project_name|
  system([project_name, 'once'].join(' '))
end

Alors('bumper la version de {string}') do |project_name|
  system([project_name, 'bump'].join(' '))
end

Alors('déployer le projet {string}') do |project_name|
  system([project_name, 'release'].join(' '))
end
