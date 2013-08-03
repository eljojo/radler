module Radler
  module CommandLine
    class BasicCommandLineApp
      def initialize(args = nil)
        args       = (args || ARGV).dup
        @command   = args.shift
        @command ||= 'default_command'
        @command   = @command.to_sym
        @args      = args
      end

      def route
        send(@command) if respond_to?(@command, true)
      end

      private
      def default_command
        nil
      end
    end
  end
end
