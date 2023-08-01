require 'google/cloud/storage'
require 'yaml'
require 'rspec/mocks'
require 'gcp_storage_repository'

RSpec.describe RubyRemoteConfig::GcpStorageRepository do
  describe '#refresh' do
    it 'reads the YAML file from the GCS bucket and unmarshals it into the data map' do
      # Create a mock storage object
      storage_mock = instance_double(Google::Cloud::Storage::Project)

      # Create a mock bucket object
      bucket_mock = instance_double(Google::Cloud::Storage::Bucket)

      # Create a mock file object
      file_mock = instance_double(Google::Cloud::Storage::File)

      # Set up the expectations for the mock objects
      allow(Google::Cloud::Storage).to receive(:new).and_return(storage_mock)
      allow(storage_mock).to receive(:bucket).with('my-bucket').and_return(bucket_mock)
      allow(bucket_mock).to receive(:file).with('my-file').and_return(file_mock)
      allow(file_mock).to receive(:download).and_return('config_name: { key: value }')

      # Create a new GcpStorageRepository object
      repo = RubyRemoteConfig::GcpStorageRepository.new(name: 'test', bucket_name: 'my-bucket', object_name: 'my-file')

      # Call the refresh method
      repo.refresh

      # Check that the data map is set correctly
      expect(repo.get_data('config_name')).to eq({ 'key' => 'value' })
    end

    it 'raises an error if there is an error refreshing the configuration data' do
      # Create a mock storage object that raises an error when creating a bucket
      storage_mock = instance_double(Google::Cloud::Storage::Project)
      allow(Google::Cloud::Storage).to receive(:new).and_return(storage_mock)
      allow(storage_mock).to receive(:bucket).and_raise(StandardError.new('Error creating bucket'))

      # Create a new GcpStorageRepository object
      repo = RubyRemoteConfig::GcpStorageRepository.new(name: 'test', bucket_name: 'my-bucket', object_name: 'my-file')

      # Call the refresh method and check that it raises an error
      expect { repo.refresh }.to raise_error('Error refreshing configuration data: Error creating bucket')
    end
  end
end