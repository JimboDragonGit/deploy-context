module Context
  module CommandHelper
    def debug?
      ENV.key?('CONTEXTDEBUG') && ! ENV['CONTEXTDEBUG'].nil? && ENV['CONTEXTDEBUG']
    end

    def log(message)
      puts message
    end

    def debug_log(message)
      log message if false # if debug?
    end

    def error_log(name, message)
      error_message = "\n\n#{name} ERROR: #{message}\n\n"
      log error_message
      exit 1
    end

    def is_admin?
      Process::Sys.getuid != 0
    end

    def temp_dir
      File.join(context_folder, 'results')
    end

    def get_shell_data(command_line)
      debug_log "Get data from command #{command_line.join(' ')}"
      `#{command_line.join(' ')}`
    end

    def execute_command(command)
      command_status = system(command.join(' '))
      log "executed command #{command.join(' ')}"
      command_status
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

    def delete_file_only_if_exist(file)
      FileUtils.rm file if File.exist? file
    end
  end
end
