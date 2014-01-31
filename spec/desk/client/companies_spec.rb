require 'helper'

describe Desk::Client do
  context "Company" do

    let(:endpoint) { "company" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "Acme Inc" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    it_behaves_like "a create endpoint", { :name => "Acme Inc" }

    it_behaves_like "an update endpoint", { :name => "Acme Enterprises" } do
      let(:check_value) { "Acme Enterprises" }
    end

    it_behaves_like "a search endpoint", { :q => "acme" }

  end
end
