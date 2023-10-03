#!/usr/bin/env ruby

require_relative '../../deploy-context'

puts "Parameter pass #{ARGV[0]}"
deployer = Context::DeployContext.deployer
deployer.execute_action(deployer, ARGV[0])
