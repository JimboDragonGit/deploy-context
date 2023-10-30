
Étantdonné('le gem {word}') do |gem_ton_install|
  context_suite.gem_ton_install = gem_ton_install
  context_log "Installing #{context_suite.gem_ton_install}"
end

Alors('installer le gem {word}') do |gem_ton_install|
  context_suite.gem_ton_install = gem_ton_install
  stop_test("Gem #{context_suite.gem_ton_install} fail to install", :install_fail) unless system("gem install #{context_suite.gem_ton_install}")
end
