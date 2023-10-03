#!/usr/bin/env ruby

require_relative '../../deploy-context'

if ARGV[0].nil?
  deployer.cycle
else
  case ARGV[0]
  when 'once'
    puts "Parameter passe #{ARGV[0]}"
    deployer.cycle
  when 'always'
    while true do
      deployer.cycle
    end
  when 'bump'
    deployer.minor_bump
  when 'release'
    deployer.major_bump
  else
    puts "Unkonown setting #{ARGV[0]}"
  end
end
