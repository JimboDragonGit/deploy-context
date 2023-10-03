#!/usr/bin/env ruby

require_relative '../../deploy-context'

puts "Parameter pass #{ARGV[0]}"

Context::DeployContext.deployer.execute_action(deployer, ARGV[0])
