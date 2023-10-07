module Context
  module DeployHelpers
    module ContextHelper
      def present_localy?
        Dir.exist?(context_folder)
      end

      def shorten_version(context)
        context.version.canonical_segments[0..2].join('.')
      end

      def actual_working_directory?
        Dir.pwd == context_folder
      end
  
      def move_folder(folder)
        @context_folder = folder.include?(context_name) ? folder : File.join(folder, context_name)
      end
  
      def check_folder(folder)
        FileUtils.mkdir_p(context_folder) unless present_localy?
      end
  
      def show_new_version(level)
        log "#{level} bump #{context_name} at newer version #{version}"
      end
  
      def is_present_publicly?
        ruby_check_if_available_public(self)
      end
  
      def new_update_available?
        git_update_available?(self)
      end
  
      def ready_for_major_update?
        false
      end
    end
  end
end