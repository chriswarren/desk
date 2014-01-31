require 'helper'

describe Desk::Client do
  context "Filter" do

    let(:endpoint) { "filter" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "My Active Cases" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    context "Case" do

      let(:sub_endpoint) { "case" }
      let(:sub_id) { 1 }
      let(:check_key) { "subject" }
      let(:check_value) { "Welcome" }

      it_behaves_like "a sub list endpoint", false

    end
  end
end
