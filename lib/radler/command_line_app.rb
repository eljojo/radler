require "radler/command_line/basic_command_line_app"
require "radler/command_line/settings"

module Radler
  class CommandLineApp < CommandLine::BasicCommandLineApp
    private
    def settings
      CommandLine::Settings.new(@args).route
    end
    alias_method :default_command, :settings
  end
end
