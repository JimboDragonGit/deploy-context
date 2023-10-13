#
# Cookbook:: deploy-context
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

# deployer = Context::DeployContext.deployer
# deployer.cucumber

knife_test 'deploycontext' do
  action [:initialize, :planning, :execution, :closure]
end


# execute 'knife context git initialisation'
