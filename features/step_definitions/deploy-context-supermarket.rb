
Étantdonné('le cookbook {word}') do |cookbook_to_install|
  context_suite.cookbook_to_install = cookbook_to_install
  given_cookbook(context_suite, cookbook_to_install)
end

Alors('partager le cookbook {word}') do |cookbook_to_install|
  context_suite.cookbook_to_install = cookbook_to_install
  then_install_cookbook(cookbook_to_install)
end
