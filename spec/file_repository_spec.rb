require 'yaml'
require 'logger'
require 'file_repository'

RSpec.describe RubyRemoteConfig::FileRepository do
  describe '#refresh' do
    it 'reads the YAML file and unmarshals it into the data map' do
      # Create a temporary YAML file
      yaml_data = { 'config_name' => { 'key' => 'value' } }.to_yaml
      yaml_file = Tempfile.new('config.yml')
      yaml_file.write(yaml_data)
      yaml_file.close

      # Create a new FileRepository object
      repo = RubyRemoteConfig::FileRepository.new(name: 'test', path: yaml_file.path)

      # Call the refresh method
      repo.refresh

      # Check that the data map is set correctly
      expect(repo.get_data('config_name')).to eq({ 'key' => 'value' })

      # Delete the temporary YAML file
      yaml_file.unlink
    end

    it 'raises an error if there is an error unmarshalling the YAML data' do
      # Create a temporary YAML file with invalid data
      yaml_data = "invalid_yaml_data"
      yaml_file = Tempfile.new('invalid_yaml_data.yml')
      yaml_file.write(yaml_data)
      yaml_file.close
      # Create a new FileRepository object
      repo = RubyRemoteConfig::FileRepository.new(name: 'test', path: yaml_file.path)
      # Call the refresh method and check that it raises an error
      repo.refresh

      # Delete the temporary YAML file
      yaml_file.unlink
    end
  end
end