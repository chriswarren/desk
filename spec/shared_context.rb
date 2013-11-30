shared_context "basic configuration" do
    subject(:client) {
      Desk::Client.new(
        :subdomain => "example",
        :consumer_key => 'CK',
        :consumer_secret => 'CS',
        :oauth_token => 'OT',
        :oauth_token_secret => 'OS'
      )
    }
end

shared_context "plural endpoint" do
  let(:endpoints) { "#{endpoint}s" }
  let(:sub_endpoints) { "#{sub_endpoint}s" }
end
