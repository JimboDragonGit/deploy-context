
require_relative '../../../../libraries/deploy-context'

extend Context::CucumberSuiteHelper

title 'deploy-context environment variables control'
control_deploy_context_environment_variables
