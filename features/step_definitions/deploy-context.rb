Étantdonnéque('le projet {word} à la bonne version') do |project_name|
  if project_name == deployer.context_name
    Dir.chdir deployer.context_folder
  else
    Dir.chdir File.join(deployer.contexts_container(deployer), project_name)
  end
end

Alors('démarrer un simple cycle de {word}') do |project_name|
  system([project_name, 'once'].join(' '))
end

Alors('bumper la version de {word}') do |project_name|
  system([project_name, 'bump'].join(' '))
end

Alors('déployer le projet {word}') do |project_name|
  system([project_name, 'release'].join(' '))
end

Alors('tester le projet {word}') do |project_name|
  system([project_name, 'test'].join(' '))
end
