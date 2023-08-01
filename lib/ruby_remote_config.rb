require 'yaml'
require 'concurrent'
require 'file_repository'
require 'gcp_storage_repository'
require 'web_repository'
require 'repository'



module RubyRemoteConfig
  class Client
    attr_reader :repository, :refresh_interval, :cancel
    def initialize(repository: Repository, refresh_interval: Integer)
      # Create the Client instance with the provided repository and refresh interval.
      @repository = repository
      @refresh_interval = refresh_interval

      @cancel = Concurrent::MutexAtomicBoolean.new(false)

      # Refresh the configuration data for the first time to ensure the
      # Client is initialized with the latest data before it is used.
      @repository.refresh

      # Start the background refresh goroutine by calling the refresh function
      # with the newly created context and the client as arguments.
      Thread.new { refresh() }

      # Return the created Client instance, which is now ready to use.
      self
    end

    def refresh
      loop do
        sleep(refresh_interval)
        @repository.refresh()
        break if @cancel
      end
    end

    def stop
      @cancel.make_true
    end
  end
end