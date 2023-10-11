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

    def warning_log(name, message)
      warning_message = "\n\n#{name} WARNING: #{message}\n\n"
      log warning_message
    end

    def error_log(name, message)
      error_message = "\n\n#{name} ERROR: #{message}\n\n"
      log error_message
      log caller
      abort(error_message)
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

    def execute_command(command, command_type = :system)
      command_state = case command_type
      when :system
        system(command.join(' '))
      when :run_as_admin
        execute_command(sudo_command(command), command_type)
      when :get_data
        debug_log "get data command = #{command} on type #{command_type}"
        get_shell_data(command)
      when :fork
        fork(command.join(' '))
      else
        error_log(context_name, "Unknown command type #{command_type}")
      end
      debug_log "\n\nexecuted command #{command.join(' ')}"
      command_state
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

    def delete_folder_only_if_exist(folder)
      FileUtils.rm_dir folder if File.exist? folder
    end

    def is_binary_available?(binary_name)
      execute_command(['which', binary_name])
    end
  end
end
