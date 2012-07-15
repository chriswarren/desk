require 'helper'

describe Assistly::Client do
  it "should connect using the endpoint configuration" do
    client = Assistly::Client.new
    endpoint = URI.parse(client.api_endpoint)
    connection = client.send(:connection).build_url("./").to_s.strip
    connection.should == endpoint.to_s
  end
end
