
require_relative 'libraries/deploy-context/helpers/gemspec.rb'

::Gem::Specification.new do |s|
  extend Context::GemHelpers
  deploycontext_gem_specification(s)
end
