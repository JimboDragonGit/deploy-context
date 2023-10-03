#!/usr/bin/env ruby

require_relative '../../deploy-context'

Context::DeployContext.deployer.execute_action(deployer, ARGV[0])
