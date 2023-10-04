
task :default => "test" do
  deployer.execute_action(deployer, 'once')
end

task :bump do
  deployer.execute_action(deployer, 'bump')
end

task :test do
  deployer.execute_action(deployer, 'test')
end
