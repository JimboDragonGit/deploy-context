require_relative 'deploy'

module Context
  class DefaultDeploy < Deploy
    def actions_permitted?(action)
      log "Is Default action '#{action}' permitted?"
      permitted = %w(
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
        build_in_habitat
      )
      action_is_permit = permitted.include?(action)

      log "The answer is #{action_is_permit} through '#{permitted}'"
      action_is_permit
    end

    def do_mix_cookbook
      mix_run_list(self, context_name)
    end

    # 2
    def do_download
      do_clean

      system %w(gem install
        chef-bin
        chef-cli
        cheffish
        kitchen-vagrant
        kitchen-dokken
        kitchen-ec2
        simplecov
        cucumber
        down
        unix-crypt
        ruby-shadow
        securerandom
        git-version-bump
      ).join(' ')
      true
    end
    
    # 3
    # def do_verify
    # end
    
    # 4
    def do_clean
      delete_file_only_if_exist(get_context_file(self, 'Gemfile.lock'))
      delete_file_only_if_exist(get_context_file(self, 'Policyfile.lock.json'))
      delete_file_only_if_exist(get_context_file(self, 'respond.txt'))
      true
    end
    
    # 5
    # def do_unpack
    # end
    
    # 6
    def do_prepare
      require 'bundler/installer'
      require 'bundler/setup'
      load_dependencies
      git_build(self)
    end
    
    # 7
    def do_build
      Dir.chdir '/src'
      do_mix_cookbook
    
      # puts "kitchen is not working" unless system('kitchen test')
      # puts "cucumber is not working" unless system('cucumber') 
      # puts "cucumber is not working" unless system('rake')
      # File.write('respond.txt', "yes\n")
      # puts "chef-client is not working" unless system('chef-client < respond.txt')
      # puts "chef cli is not available" unless system('chef exec echo < respond.txt')
    
      # do_mix_cookbook 'jimbodragon::do_default_build'
      # chef gem build
    end
    
    # 8
    # def do_check
    # end
    
    # 9
    # def do_install
    # end
    
    # 10
    # def do_strip
    # end
    
    # 11
    # def do_end
    # end
  end
end