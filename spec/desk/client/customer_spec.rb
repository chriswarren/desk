require 'helper'

describe Desk::Client do
  context "Customer" do

    let(:endpoint) { "customer" }
    let(:id) { 1 }
    let(:check_key) { "first_name" }
    let(:check_value) { "John" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    it_behaves_like "a create endpoint", {
      :first_name => "John",
      :last_name => "Doe"
    }

    it_behaves_like "an update endpoint", { :first_name => "Johnny" } do
      let(:check_value) { "Johnny" }
    end

    it_behaves_like "a search endpoint", { :since_created_at => 1385074763 }

  end
end
