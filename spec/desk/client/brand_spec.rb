require 'helper'

describe Desk::Client do
  context "Brand" do

    let(:endpoint) { "brand" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "Desk.com" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

  end
end
