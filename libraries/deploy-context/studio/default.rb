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
    end
  end
end