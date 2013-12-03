require 'helper'

describe Desk::Client do
  context "Topic" do

    let(:endpoint) { "topic" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "Customer Support" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    it_behaves_like "a create endpoint", { :name => "Social Media" }

    it_behaves_like "an update endpoint", { :name => "New Name" } do
      let(:check_value) { "New Name" }
    end

    it_behaves_like "a delete endpoint"

    context "Translation" do

      let(:sub_endpoint) { "translation" }
      let(:sub_id) { "en_us" }
      let(:check_key) { "name" }
      let(:check_value) { "Customer Support" }

      it_behaves_like "a sub list endpoint"

      it_behaves_like "a sub show endpoint"

      it_behaves_like "a sub create endpoint", {
        :name => "Japanese",
        :locale => "ja"
      } do
        let(:check_value) { "Japanese" }
      end

      it_behaves_like "a sub update endpoint", {
        :name => "Updated Japanese Translation"
      } do
        let(:sub_id) { "ja" }
        let(:check_value) { "Updated Japanese Translation" }
      end

      it_behaves_like "a sub delete endpoint"

    end
  end
end
