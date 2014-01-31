require 'helper'

describe Desk::Client do
  context "Group" do

    let(:endpoint) { "group" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "Support Ninjas" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    context "Filter" do

      let(:sub_endpoint) { "filter" }
      let(:sub_id) { 1 }
      let(:check_value) { "My Active Cases" }

      it_behaves_like "a sub list endpoint", false

    end

    context "User" do

      let(:sub_endpoint) { "user" }
      let(:sub_id) { 1 }
      let(:check_value) { "John Doe" }

      it_behaves_like "a sub list endpoint", false

    end
  end
end
