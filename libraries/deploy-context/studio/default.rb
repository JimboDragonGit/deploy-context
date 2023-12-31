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
          do_mix_cookbook
          do_agent
        )
      end

      def do_mix_cookbook
        cookbook_result = mix_run_list(self, context_name)
        context_log "Mix the cookbook #{context_name}: #{cookbook_result.class}"
      end

      def do_agent
        git_build(self)
        while true do
          do_mix_cookbook
        end
      end
    end
  end
end
