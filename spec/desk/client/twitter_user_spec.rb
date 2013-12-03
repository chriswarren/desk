require 'helper'

describe Desk::Client do
  context "Twitter User" do

    let(:endpoint) { "twitter_user" }
    let(:id) { 1 }
    let(:check_key) { "handle" }
    let(:check_value) { "desk_dev" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    it_behaves_like "a create endpoint", {
      :handle => "desk_dev",
      :_links => {
        :customer => {
          :href => "/api/v2/customers/1",
          :class => "customer"
        }
      }
    }
  end
end
