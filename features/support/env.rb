
require 'ostruct'

require_relative '../../libraries/deploy-context'

include Context::CucumberSuiteHelper
include Context::DeployKnifeConstant
# set_context('jimbodragon', 'deploy-context', File.dirname(File.dirname(__dir__)))