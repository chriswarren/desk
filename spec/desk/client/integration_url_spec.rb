require 'helper'

describe Desk::Client do
  context "Integration URL" do

    let(:endpoint) { "integration_url" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "Sample URL" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    it_behaves_like "a create endpoint", {
      :name => "Sample URL",
      :description => "A sample Integration URL",
      :markup => "http://www.example.com"
    }

    it_behaves_like "an update endpoint", { :enabled => false }

    it_behaves_like "a delete endpoint"

  end
end
