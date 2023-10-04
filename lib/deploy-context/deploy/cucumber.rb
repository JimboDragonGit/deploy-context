module Context
  module DeployHelpers
    module CucumberHelper
      def cucumber_test(context)
        git_build(context)
        puts "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        cucumber
      end
    end
  end
end
