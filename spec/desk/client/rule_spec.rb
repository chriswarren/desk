require 'helper'

describe Desk::Client do
  context "Rule" do

    let(:endpoint) { "rule" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "Assign to Support" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

  end
end
