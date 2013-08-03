module Radler
  class VaultArchive
    attr_accessor :archive_id, :description, :created_at, :size, :sha_hash, :vault_arn

    def initialize(attrib = {})
      update_attributes(attrib)
    end

    def save
      return nil unless archive_id
      connection.put_attributes(Radler::SIMPLEDB_DOMAIN, archive_id, attributes)
    end

    def load
      return nil unless archive_id
      result = connection.get_attributes(Radler::SIMPLEDB_DOMAIN, archive_id)
      attributes = data.body["Attributes"]
      return nil if attributes.empty?
      update_attributes(attributes)
    end

    private
    def update_attributes(attrib)
      attrib.each do |key, value|
        setter = "#{key}=".to_sym
        unless self.respond_to?(setter)
          raise ArgumentError.new("VaultArchive doesn't respond to #{key}")
        end
        # SimpleDB stores values as arrays
        value = value.first if value.is_a?(Array)
        self.send(setter, value)
      end
    end

    def attributes
      keys = [:archive_id, :description, :created_at, :size, :sha_hash, :vault_arn]
      result = keys.map { |key| [key, self.send(key)] }
      Hash[result]
    end

    def connection
      self.class.connection
    end

    class << self
      def from_inventory(inventory)
        raise ArgumentError unless inventory.is_a? Hash
        archives = inventory["ArchiveList"]
        archives.map do |data|
          self.new(
            archive_id: data["ArchiveId"],
            description: data["ArchiveDescription"],
            created_at: DateTime.parse(data["CreationDate"]),
            size: data["Size"],
            sha_hash: data["SHA256TreeHash"],
            vault_arn: inventory["VaultARN"]
          )
        end
      end

      def connection
        # this shit is not threadsafe
        @connection ||= Fog::AWS::SimpleDB.new(Radler.settings.raw)
      end

      def all
        create_domain unless domain_exists?
        result = connection.select("select * from `#{Radler::SIMPLEDB_DOMAIN}`")
        archives = result.body["Items"].values
        archives.map { |archive| self.new(archive) }
      end

      private
      def create_domain
        connection.create_domain(Radler::SIMPLEDB_DOMAIN)
      end

      def domain_exists?
        response = connection.list_domains
        response.body["Domains"].include?(Radler::SIMPLEDB_DOMAIN)
      end
    end
  end
end
