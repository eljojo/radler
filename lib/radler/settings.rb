module Radler
  class Settings
    attr_accessor :aws_access_key_id, :aws_secret_access_key

    def initialize(file = nil)
      @file_path = file || File.expand_path('~/.radler_keys')
    end

    def filename
      @file_path
    end

    def persisted?
      File.exists? filename
    end

    def load
      return nil unless persisted?
      self.aws_access_key_id, self.aws_secret_access_key = File.read(filename).split(':')
    end

    def save
      raise "FileAlreadyExists" if persisted?
      File.write filename, [aws_access_key_id, aws_secret_access_key].join(':')
    end

    def valid?
      load if persisted?
      !aws_access_key_id.nil? && !aws_secret_access_key.nil?
    end
  end
end
