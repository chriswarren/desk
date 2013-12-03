require 'helper'

describe Desk::Client do
  context "Label" do

    let(:endpoint) { "label" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "MyLabel" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    it_behaves_like "a create endpoint", {
      :name => "MyLabel",
      :description => "A Test Label",
      :types => [ "case", "macro" ],
      :color => "blue"
    }

    it_behaves_like "an update endpoint", { :name => "Label 5" } do
      let(:check_value) { "Label 5" }
    end

    it_behaves_like "a delete endpoint"

  end
end
