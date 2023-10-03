Étantdonnéque('deploy-context est présent localement') do
end

Étantdonnéque('deploy-context est présent au public') do
end

Étantdonnéque('deploy-context est tester avec succès') do
end

Alors('compiler deploy-context') do
  deployer.build
end

Alors('publié deploy-context') do
  deployer.commit
  deployer.patch_bump
  deployer.release
end

Alors('attendre que deploy-context soit disponible au public') do
  deployer.wait_release_available
  puts "Waiting a minute before installing"
  sleep(60)
end

Alors('installer deploy-context') do
  deployer.install
end

Alors('tester deploy-context') do
  if deployer.test_context_successful?
    puts "newer version installed successfully for #{deployer.context_name} and version #{GVB.version}"
    deployer.patch_bump
    # patch_reset(context)
  else
    puts "newer version not installed for #{deployer.context_name} and version #{GVB.version}"
    exit 1
  end
end

Étantdonnéque('deploy-context est absent localement') do
  deployer.clean if deployer.present_localy?
end

Alors('cloner le projet git@github.com:JimboDragonGit\/deploy-context.git') do
  deployer.clean if deployer.present_localy?
end
