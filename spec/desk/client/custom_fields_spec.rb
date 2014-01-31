require 'helper'

describe Desk::Client do
  context "Custom Fields" do

    let(:endpoint) { "custom_field" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "frequent_buyer" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

  end
end
