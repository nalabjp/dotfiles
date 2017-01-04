## Settings
Pry.config.color = true
Pry.config.editor = "nvim"

Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "#{Rails.version}@" if defined?(Rails) && Rails.respond_to?(:version)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> "
end


## Alias
#Pry.config.commands.alias_command "lM", "ls -M"
# Ever get lost in pryland? try w!
#Pry.config.commands.alias_command 'w', 'whereami'
# Clear Screen
Pry.config.commands.alias_command '.clr', '.clear'

# === Listing config ===
# Better colors - by default the headings for methods are too 
# similar to method name colors leading to a "soup"
# These colors are optimized for use with Solarized scheme 
# for your terminal
#Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# === CUSTOM COMMANDS ===
# from: https://gist.github.com/1297510
default_command_set = Pry::CommandSet.new do
  command "sql", "Send sql over AR." do |query|
    if ENV['RAILS_ENV'] || defined?(Rails)
      pp ActiveRecord::Base.connection.select_all(query)
    else
      pp "No rails env defined"
    end
  end
end
Pry.config.commands.import default_command_set

## Below others cooperation
# refs: https://github.com/pry/pry/wiki/FAQ#wiki-awesome_print
begin
  require 'awesome_print'
  #Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
  Pry.config.print = proc { |output, value| output.puts value.ai } #ページングなし
rescue LoadError => err
  puts "no awesome_print :("
end

# refs: https://github.com/pry/pry/wiki/FAQ#wiki-hirb
if defined? Hirb
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

# Hit Enter to repeat last command
Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

if defined?(PryStackExplorer)
  Pry.commands.alias_command 'bt', 'show-stack'
end

# refs: https://gist.github.com/pinzolo/54cf22c9d50c6547becc#file-gistfile1-rb
Pry::DEFAULT_HOOKS.add_hook(:before_session, :gem_auto_require) do |out, target, _pry_|
  dir = `pwd`.chomp
  gem_name = File.basename(dir)
  if File.exist?(File.join(dir, "#{gem_name}.gemspec"))
    lib = File.join(dir, 'lib')
    $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
    if File.exist?(File.join(lib, "#{gem_name}.rb"))
      begin
        require gem_name
      rescue LoadError => e
        puts "gem_auto_require: #{e.message}"
      end
    end
  end
end
