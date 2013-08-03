module Radler
  module CommandLine
    class Settings < BasicCommandLineApp
      def initialize(args = nil)
        super
        @settings = ::Radler::Settings.new
      end

      private
      def set
        puts "please paste your AWS access key id"
        @settings.aws_access_key_id = STDIN.gets.strip
        puts "please paste your AWS secret access key"
        @settings.aws_secret_access_key = STDIN.gets.strip
        puts "which aws region would you like to use? (eu-west-1 / us-west-1 / etc)"
        @settings.region = STDIN.gets.strip
        puts "coolio!, now they'll be stored in #{@settings.filename}"
        @settings.save
      end

      def check
        if @settings.persisted? then
          if @settings.valid? then
            puts "settings are valid!"
          else
            puts "sorry, the file #{@settings.filename} exists, but it doesn't seem to be valid."
          end
        else
          puts "i'm sorry, but the file #{@settings.filename} doesn't exist"
        end
      end

      def default_command
        @settings.persisted? ? check : set
      end
    end
  end
end
