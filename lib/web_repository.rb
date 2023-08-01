# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'yaml'
require 'logger'
require "repository"

module Source
  class WebRepository
    include Source::Repository
    attr_reader :url

    def initialize(name:, url:)
      super(name: name)
      @url = URI.parse(url)
    end

    def refresh
      @lock.synchronize do
        http = Net::HTTP.new(@url.host, @url.port)
        http.use_ssl = @url.scheme == 'https'

        request = Net::HTTP::Get.new(@url)
        response = http.request(request)

        if response.code == '200'
          @raw_data = response.body
          @data = YAML.safe_load(@raw_data)
        else
          raise "Failed to fetch data from #{@url}: #{response}"
        end
      end
    end

  end
end
