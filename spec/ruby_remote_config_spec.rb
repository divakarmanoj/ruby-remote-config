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
  end
end