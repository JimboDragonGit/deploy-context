
Étantdonné('le gem {word}') do |gem_to_install|
  context_suite.gem_to_install = gem_to_install
  given_gem(context_suite)
end

Alors('installer le gem {word}') do |gem_to_install|
  context_suite.gem_to_install = gem_to_install
  then_install_gem(context_suite)
end
