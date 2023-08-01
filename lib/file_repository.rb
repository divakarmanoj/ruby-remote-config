# frozen_string_literal: true

require "yaml"
require "logger"
require "repository"

module RubyRemoteConfig
  # FileRepository is a struct that implements the Repository interface for
  # handling configuration data stored in a YAML file.
  class FileRepository
    include RubyRemoteConfig::Repository
    attr_reader :path

    def initialize(name:, path:)
      super(name: name)
      @path = path
    end

    # Refresh reads the YAML file, unmarshal it into the data map.
    def refresh
      @lock.synchronize do
        # Read the YAML file
        data = File.read(@path)
        # Unmarshal the YAML data into the data map
        @data = YAML.safe_load(data)

        # Store the raw data of the YAML file
        @raw_data = data
      end
    end
  end
end