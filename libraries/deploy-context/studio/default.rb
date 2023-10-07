require_relative 'base'

module Context
  module Studio
    module Default
      def actions_permitted
        %w(
          do_begin
          do_download
          do_verify
          do_clean
          do_unpack
          do_prepare
          do_build
          do_check
          do_install
          do_strip
          do_end
          help
          do_build_in_habitat
          do_promote
        )
      end

      def do_mix_cookbook
        mix_run_list(self, context_name)
      end

      # 4
      def do_clean
        delete_file_only_if_exist(get_context_file(self, 'respond.txt'))
        true
      end
      
      # 6
      def do_prepare
        # load_dependencies
        git_build(self)
      end
      
      # 7
      def do_build
        git_commit(self)
      end
      
      # 8
      def do_check
      end
      
      # 9
      def do_install
        ruby_release(self)
        true
      end
      
      # 10
      # def do_strip
      # end
      
      # 11
      def do_end
      end
    end
  end
end