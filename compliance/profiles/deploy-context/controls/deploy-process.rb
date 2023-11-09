# Cookbook:: deploy-context

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

require_relative '../../../../libraries/deploy-context'

extend Context::CucumberSuiteHelper

title 'deploy-context cucumber json status control'
control_json_report
