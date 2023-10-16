module Context
  module DeployHelpers
    module ChefHelper
      def prepare_workplan
        FileUtils.mkdir 'workstation-space' unless Dir.exist?('workstation-space')
        prepare_chef
        prepare_gem
        prepare_ssh
        prepare_git
      end

      def prepare_chef
        FileUtils.cp_r '/etc/chef', 'workstation-space/chef-client'

        chef_user_keys_folder = 'workstation-space/chef_user_keys'

        FileUtils.mkdir chef_user_keys_folder unless Dir.exist?(chef_user_keys_folder)

        FileUtils.cp File.join(ENV['HOME'],'.chef/credentials'), 'workstation-space/chef_credentials'
        client_keys = File.read('workstation-space/chef_credentials').split("\n").select do |line_str|
          line_str.include?('client_key')
        end
        client_keys.each do |key_line|
          key_file = key_line.split('=')[1].strip.split("'")[1]
          debug_context_log 'Knife keys', "Copy file #{key_file} to #{chef_user_keys_folder}"
          FileUtils.cp key_file, File.join(chef_user_keys_folder, File.basename(key_file))
        end
      end

      def prepare_gem
        FileUtils.cp File.join(ENV['HOME'],'.local/share/gem/credentials'), 'workstation-space/gem_credentials'
      end

      def prepare_ssh
        FileUtils.cp_r File.join(ENV['HOME'],'.ssh'), 'workstation-space/ssh'
      end

      def prepare_git
        FileUtils.cp File.join(ENV['HOME'],'.gitconfig'), 'workstation-space/gitconfig'
      end
    end
  end
end
