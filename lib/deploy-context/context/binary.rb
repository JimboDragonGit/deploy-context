#!/usr/bin/env ruby

require_relative '../../deploy-context'

def deployer
  DEPLOYER
end

puts "Parameter pass #{ARGV[0]}"

deployer.execute_action(deployer, ARGV[0])
