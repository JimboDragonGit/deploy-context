module Context
  module DeployHelpers
    module CucumberHelper
      def cucumber_test(context)
        context.git_build(context)
        context.log "Working in folder #{Dir.pwd}\nAnd context #{context.context_name} is created in folder #{context.context_folder} at version #{context.version}"
        context.cucumber(context)
      end
    end
  end
end
