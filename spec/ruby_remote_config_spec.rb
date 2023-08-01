require "ruby_remote_config"

describe RubyRemoteConfig do
  context "Testing File Repository" do
    it "should return the correct data" do
      print(Dir.getwd)
      client = RubyRemoteConfig::Client.new(
        repository: Source::FileRepository.new(name: "test", path: "spec/test.yaml"),
        refresh_interval: 1)
      expect(client.repository.get_data("test")).to eq("test")
      client.stop
    end
    it "Change the data in the file and check if the data is updated" do
      client = RubyRemoteConfig::Client.new(
        repository: Source::FileRepository.new(name: "test", path: "spec/test.yaml"),
        refresh_interval: 1)
      expect(client.repository.get_data("test")).to eq("test")
      File.open("spec/test.yaml", "w") { |file| file.write("test: test1") }
      expect(client.repository.get_data("test")).to eq("test1")
      client.stop
    end
  end
end