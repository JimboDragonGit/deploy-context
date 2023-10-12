require_relative 'habitat-studio'

module Context
  class ContextCucumberStudio < DefaultStudio
    banner "knife context cucumber studio"

    deps do
      Knife::DefaultKnifeContext.load_deps
    end

    option :omg,
      :short => '-O',
      :long => '--omg',
      :description => "I'm so excited! 9"

    def run
      if config[:omg]
        puts "OMG HELLO WORLD!!!9!!99"
      else
        puts "I am just a fucking example. 9"
      end
    end

    def studio_available?
      is_binary_available?('cucumber') && super
    end
  end
end
