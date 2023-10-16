module Context
  module CommandHelper
    def debug?
      ENV.key?('CONTEXTDEBUG') && ! ENV['CONTEXTDEBUG'].nil? && ENV['CONTEXTDEBUG']
    end

    def context_log(message)
      return context_log message if respond_to? :log
      puts message
    end

    def debug_context_log(name, message)
      return debug_log message if respond_to? :debug_log
      debug_message = "\n\n#{name} DEBUG: #{message}\n\n"
      context_log debug_message if debug?
    end

    def warning_context_log(name, message)
      return warning_log message if respond_to? :warning_log
      warning_message = "\n\n#{name} WARNING: #{message}\n\n"
      context_log warning_message
    end

    def error_context_log(name, message)
      return error_log message if respond_to? :error_log
      error_message = "\n\n#{name} ERROR: #{message}\n\n"
      context_log error_message
      context_log caller
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
      debug_context_log 'Get data from command', command_line
      `#{command_line.join(' ')}`
    end

    def execute_command(command, command_type = :system)
      command_state = case command_type
      when :system
        system(command.join(' '))
      when :run_as_admin
        execute_command(sudo_command(command), command_type)
      when :get_data
        debug_context_log "get data command = #{command} on type #{command_type}"
        get_shell_data(command)
      when :fork
        fork(command.join(' '))
      else
        error_context_log(context_name, "Unknown command type #{command_type}")
      end
      debug_context_log 'Execute Command', "\n\nexecuted command #{command.join(' ')}"
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
      debug_context_log "Write in file system", [file, content]
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
