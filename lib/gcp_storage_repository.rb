# frozen_string_literal: true

require "google/cloud/storage"
require "yaml"
require "repository"

# GcpStorageRepository is a class that implements the Repository interface for
# handling configuration data stored in a YAML file within a GCS bucket.
module Source
  class GcpStorageRepository
    include Source::Repository
    attr_reader :bucket_name, :object_name, :client

    def initialize(name:, bucket_name:, object_name:)
      super(name: name)
      @bucket_name = bucket_name
      @object_name = object_name
      @client = nil
    end

    # Refresh reads the YAML file from the GCS bucket, unmarshal it into the data map.
    def refresh
      @lock.synchronize do
        # If the GCS client does not exist, create it.
        if @client.nil?
          @client = Google::Cloud::Storage.new()
        end

        # Open the YAML file from the GCS bucket.
        bucket = @client.bucket(@bucket_name)
        file = bucket.file(@object_name)
        file_content = file.download

        # Unmarshal the YAML data into the data map.
        @data = YAML.safe_load(file_content)
        @raw_data = file_content
      end
    rescue StandardError => e
      raise "Error refreshing configuration data: #{e.message}"
    end
  end
end