require_relative 'habitat-studio'

module Context
  class ContextCucumberStudio < DefaultStudio
    banner "knife context cucumber studio"

    deps do
      Knife::DefaultKnifeContext.load_deps
    end

    def run
      case name_args[1]
      when 'destroy'
        execute_command(%w(knife context cookbook studio destroy)) if name_args[0] == 'kitchen'
      when 'enter'
        execute_command(%w(knife context habitat studio enter)) if name_args[0] == 'habitat'
      when 'build'
        execute_command(%w(knife context habitat studio build) + name_args) if name_args[0] == 'habitat'
      else
        if name_args[0]
          additionnal_tag = name_args[1].nil? ? [] : ['--tags', "@#{name_args[1]}"]
          case name_args[0]
          when 'cycle'
            cucumber(self, ['--profile', 'initialize'] + additionnal_tag)
            cucumber(self, ['--profile', 'planning'] + additionnal_tag)
            cucumber(self, ['--profile', 'execution'] + additionnal_tag)
            cucumber(self, ['--profile', 'closure'] + additionnal_tag)
            cucumber(self, ['--profile', 'post_mortem'] + additionnal_tag)
          else
            cucumber(self, ['--profile', name_args[0]] + additionnal_tag)
          end
        end
      end
    end

    def studio_available?
      is_binary_available?('cucumber') && super
    end
  end
end
