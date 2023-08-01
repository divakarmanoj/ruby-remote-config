require 'net/http'
require 'uri'
require 'yaml'
require 'logger'
require 'web_repository'

RSpec.describe Source::WebRepository do
  describe '#refresh' do
    it 'fetches the YAML data from the specified URL and unmarshals it into the data map' do
      # Create a temporary YAML file
      yaml_data = { 'config_name' => { 'key' => 'value' } }.to_yaml
      yaml_file = Tempfile.new('config.yml')
      yaml_file.write(yaml_data)
      yaml_file.close

      # Start a local HTTP server to serve the YAML file
      server = TCPServer.new('127.0.0.1', 0)
      server_port = server.addr[1]
      thread = Thread.new do
        loop do
          begin
            client = server.accept
            request = client.gets
            if request.start_with?('GET')
              client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\n#{yaml_data}"
            else
              client.puts "HTTP/1.1 404 Not Found\r\nContent-Type: text/plain\r\n\r\nNot found"
            end
            client.close
          rescue
          end
        end
      end

      # Create a new WebRepository object
      repo = Source::WebRepository.new(name: 'test', url: "http://127.0.0.1:#{server_port}/config.yml")

      # Call the refresh method
      repo.refresh

      # Check that the data map is set correctly
      expect(repo.get_data('config_name')).to eq({ 'key' => 'value' })

      # Stop the local HTTP server
      server.close
      thread.kill
    end

    it 'raises an error if the HTTP response code is not 200' do
      # Start a local HTTP server that always returns a 404 response
      server = TCPServer.new('127.0.0.1', 0)
      server_port = server.addr[1]
      thread = Thread.new do
        loop do
          begin
          client = server.accept
          client.puts "HTTP/1.1 404 Not Found\r\nContent-Type: text/plain\r\n\r\nNot found"
          client.close
          rescue
            end
        end
      end

      # Create a new WebRepository object
      repo = Source::WebRepository.new(name: 'test', url: "http://127.0.0.1:#{server_port}/config.yml")

      # Call the refresh method and check that it raises an error
      expect { repo.refresh }.to raise_error(StandardError)

      # Stop the local HTTP server
      server.close
      thread.kill
    end
  end
end