require 'helper'

describe Desk::Client do
  context "Job" do

    let(:endpoint) { "job" }
    let(:id) { 1 }
    let(:check_key) { "type" }
    let(:check_value) { "bulk_case_update" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a show endpoint"

    it_behaves_like "a create endpoint", {
      :type => "bulk_case_update",
      :case => {
        :priority => 5,
        :_links => {
          :assigned_user => {
            :href => "/api/v2/users/1",
            :class => "user"
          }
        }
      },
      :case_ids => [ 1, 2, 3 ]
    }

  end
end
