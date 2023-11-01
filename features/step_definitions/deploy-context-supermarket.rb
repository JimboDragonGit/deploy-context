
Étantdonné('le gem {word}') do |gem_to_install|
  context_suite.gem_to_install = gem_to_install
  context_log "Installing #{context_suite.gem_to_install}"
end

Alors('installer le gem {word}') do |gem_to_install|
  context_suite.gem_to_install = gem_to_install
  stop_test("Gem #{context_suite.gem_to_install} fail to install", :install_fail) unless system("gem install #{context_suite.gem_to_install}")
end

Étantdonné('le cookbook {word}') do |cookbook_to_install|
  context_suite.cookbook_to_install = cookbook_to_install
  context_log "Installing cookbook #{context_suite.cookbook_to_install}"
end

Alors('partager le cookbook {word}') do |cookbook_to_install|
  context_suite.cookbook_to_install = cookbook_to_install
  stop_test("Cookbook supermarket #{context_suite.cookbook_to_install} fail to share", :share_fail) unless system("knife supermarket share #{context_suite.cookbook_to_install} --cookbook-path ..")
end
