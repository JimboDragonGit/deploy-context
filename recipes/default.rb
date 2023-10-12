#
# Cookbook:: deploy-context
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

# deployer = Context::DeployContext.deployer
# deployer.cucumber

chef_gem 'cucumber'

Chef::Log.warn("diff-lcs = #{Gem::Specification.find_all_by_name('diff-lcs')}")

deploycontext 'deploycontext' do
  action [:initialisation, :planning, :execution, :closure]
end
