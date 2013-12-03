require 'helper'

describe Desk::Client do
  context "Site Setting" do

    let(:endpoint) { "site_setting" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "company_name" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

  end
end
