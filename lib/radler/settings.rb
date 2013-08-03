module Radler
  class Settings
    attr_accessor :aws_access_key_id, :aws_secret_access_key, :region

    def initialize(file = nil)
      @file_path = file || File.expand_path('~/.radler_keys')
      load if persisted?
    end

    def filename
      @file_path
    end

    def persisted?
      File.exists? filename
    end

    def load
      return nil unless persisted?
      data = File.read(filename).strip.split(':')
      self.aws_access_key_id, self.aws_secret_access_key, self.region = data
    end

    def save
      raise "FileAlreadyExists" if persisted?
      data = [aws_access_key_id, aws_secret_access_key, region].join(':')
      File.write filename, data
    end

    def valid?
      !invalid?
    end

    def invalid?
      load if persisted?
      aws_access_key_id.nil? or aws_secret_access_key.nil? or region.nil?
    end

    def raw
      {
        aws_access_key_id: aws_access_key_id,
        aws_secret_access_key: aws_secret_access_key,
        region: region
      }
    end
  end
end
