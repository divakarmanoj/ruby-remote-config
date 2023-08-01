# frozen_string_literal: true

module Source
  module Repository
    attr_reader :name, :data, :lock

    def initialize(name:)
      @name = name
      @data = {}
      @lock = Mutex.new
    end

    def get_name
      @name
    end

    # GetData returns the configuration data as a map of configuration names to their respective models.
    def get_data(config_name)
      @lock.synchronize do
        config = @data[config_name]
        return config
      end
    end

    def refresh
      raise NotImplementedError, 'Method not implemented'
    end
  end
end