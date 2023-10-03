#!/usr/bin/env ruby

require_relative '../../deploy-context'

def deployer
  DEPLOYER
end

puts "Parameter pass #{ARGV[0]}"

if ARGV[0].nil?
  deployer.cycle
else
  case ARGV[0]
  when 'once'
    puts "\nExecute only once\n"
    deployer.cycle
  when 'always'
    puts "\nAlways in execution\n"
    while true do
      deployer.cycle
    end
  when 'bump'
    puts "\nBump minor version\n"
    deployer.minor_bump
  when 'release'
    puts "\nBump major version\n"
    deployer.major_bump
  when 'test'
    puts "\nExecute tests\n"
    deployer.cucumber_test(deployer)
  else
    puts "Unknown setting #{ARGV[0]}"
  end
end
