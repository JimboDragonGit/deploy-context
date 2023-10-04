module Context
  module CommandHelper
    def debug?
      ENV.key?('CONTEXTDEBUG') && ! ENV['CONTEXTDEBUG'].nil? && ENV['CONTEXTDEBUG']
      true
    end

    def log(message)
      puts message
    end

    def debug_log(message)
      log message if debug?
    end

    def is_admin?
      Process::Sys.getuid != 0
    end

    def temp_dir
      @temp_dir = Dir.tmpdir() if @temp_dir.nil?
      @temp_dir
    end

    def get_data(command_line)
      debug_log "Get data from command #{command_line.join(' ')}"
      `#{command_line.join(' ')}`
    end

    def execute_command(command)
      system(command.join(' '))
      debug_log "executed command #{command.join(' ')}"
    end

    def sudo_command(command)
      if ! Gem.win_platform? && Process::Sys.getuid != 0
        ['sudo'] + command
      else
        command
      end
    end

    def write_in_system_file(file, content)
      debug_log "write_in_system_file #{[file, content]}"
      system("touch #{file}")
      ::File.write(file, content)
      system("chmod 644 #{file}") unless Gem.win_platform?
    end
  end
end
