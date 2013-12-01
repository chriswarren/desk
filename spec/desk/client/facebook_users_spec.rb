require 'helper'

describe Desk::Client do
  context "Facebook User" do

    let(:endpoint) { "facebook_user" }
    let(:id) { 1 }
    let(:check_key) { "profile_url" }
    let(:check_value) { "https://www.facebook.com/zuck" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"
  end
end
