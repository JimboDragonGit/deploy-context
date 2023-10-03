require 'deploy-context'

Étantdonnéque('deploy-context est présent localement') do
  deployer = Context::DeployContext.new(ENV['DEPLOY_CONTEXT_FOLDER'])
end

Étantdonnéque('deploy-context est présent au public') do
  deployer = Context::DeployContext.new(ENV['DEPLOY_CONTEXT_FOLDER'])
end

Étantdonnéque('deploy-context est tester avec succès') do
  deployer = Context::DeployContext.new(ENV['DEPLOY_CONTEXT_FOLDER'])
end

Alors('compiler deploy-context') do
  deployer = Context::DeployContext.new(ENV['DEPLOY_CONTEXT_FOLDER'])
  deployer.build
end

Alors('publié deploy-context') do
  deployer = Context::DeployContext.new(ENV['DEPLOY_CONTEXT_FOLDER'])
  deployer.commit
  deployer.patch_bump
  deployer.release
end

Alors('attendre que deploy-context soit disponible au public') do
  deployer = Context::DeployContext.new(ENV['DEPLOY_CONTEXT_FOLDER'])
  deployer.wait_release_available
  puts "Waiting a minute before installing"
  sleep(60)
end

Alors('installer deploy-context') do
  deployer = Context::DeployContext.new(ENV['DEPLOY_CONTEXT_FOLDER'])
  deployer.install
end

Alors('tester deploy-context') do
  deployer = Context::DeployContext.new(ENV['DEPLOY_CONTEXT_FOLDER'])
  if deployer.test_context_successful?
    puts "newer version installed successfully for #{deployer.context_name} and version #{GVB.version}"
    deployer.patch_bump
    # patch_reset(context)
  else
    puts "newer version not installed for #{deployer.context_name} and version #{GVB.version}"
    exit 1
  end
end
