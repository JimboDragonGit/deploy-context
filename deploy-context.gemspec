
require_relative 'libraries/deploy-context/helpers/gemspec.rb'

::Gem::Specification.new do |s|
  extend Context::GemHelpers
  deploycontext_rootfolder = __dir__
  libraries = File.join(deploycontext_rootfolder, 'libraries')
  steps = File.join(deploycontext_rootfolder, 'features/step_definitions'))
  deploycontext_gem_specification(s, deploycontext_rootfolder, libraries, steps)
end
