require 'helper'

describe Desk::Client do
  context "User" do

    let(:endpoint) { "user" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "John Doe" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    context "Preference" do

      let(:sub_endpoint) { "preference" }
      let(:sub_id) { 1 }
      let(:check_key) { "name" }
      let(:check_value) { "enable_routing_filter_on_login" }

      it_behaves_like "a sub list endpoint"

      it_behaves_like "a sub show endpoint"

      it_behaves_like "a sub update endpoint", { :value => true } do
        let(:sub_id) { 3 }
        let(:check_value) { "auto_accept_on_route" }
      end

    end
  end
end
