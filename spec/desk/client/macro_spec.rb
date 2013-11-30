require 'helper'
require 'shared_examples'

describe Desk::Client do
  context "Macro" do

    let(:endpoint) { "macro" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "Macro Macro" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    it_behaves_like "a create endpoint", {
      :name => "Macro Macro",
      :description => "It's raining fire!"
    }

    it_behaves_like "an update endpoint", { :description => "On repeat" }

    it_behaves_like "a delete endpoint"

    context "Action" do

      let(:sub_endpoint) { "action" }
      let(:sub_id) { 1 }
      let(:check_key) { "value" }
      let(:check_value) { "From a VIP Customer" }

      it_behaves_like "a sub list endpoint"

      it_behaves_like "a sub show endpoint"

      it_behaves_like "a sub update endpoint", { :enabled => false }

    end
  end
end
