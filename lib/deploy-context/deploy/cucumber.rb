module Context
  module CucumberDeployerHelper
    def cucumber_build(context)
      git_build(context)
      Dir.chdir context.context_folder
      puts "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created"
      cucumber
    end
  end
end