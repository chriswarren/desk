require 'helper'

describe Desk::Client do
  context "Twitter Account" do

    let(:endpoint) { "twitter_account" }
    let(:id) { 1 }
    let(:check_key) { "handle" }
    let(:check_value) { "desk_dev" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    context "Tweet" do

      let(:sub_endpoint) { "tweet" }
      let(:sub_id) { 1 }
      let(:check_key) { "body" }
      let(:check_value) { "Example tweet" }

      it_behaves_like "a sub list endpoint"

      it_behaves_like "a sub show endpoint"

      it_behaves_like "a sub create endpoint", { :body => "Example Tweet" }

    end
  end
end
