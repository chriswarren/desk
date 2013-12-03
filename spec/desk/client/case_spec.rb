require 'helper'

describe Desk::Client do
  context "Case" do

    let(:endpoint) { "case" }
    let(:id) { 1 }
    let(:check_key) { "subject" }
    let(:check_value) { "Welcome" }

    include_context "basic configuration"

    it_behaves_like "a list endpoint"

    it_behaves_like "a search endpoint", {
      :subject => "please help",
      :name => "jimmy"
    }

    it_behaves_like "a show endpoint"

    it_behaves_like "a create endpoint", {
      :type => "email",
      :subject => "Creating a case via the API",
      :priority => 4,
      :status => "open",
      :labels => [ "Spam", "Ignore" ],
      :created_at => "2012-05-01T21:38:48Z",
      :_links => {
        :customer => {
          :href => "/api/v2/customers/1",
          :class => "customer"
        },
        :assigned_user => {
          :href => "/api/v2/users/1",
          :class => "user"
        },
        :assigned_group => {
          :href => "/api/v2/groups/1",
          :class => "group"
        },
        :locked_by => {
          :href => "/api/v2/users/1",
          :class => "user"
        }
      },
      :message => {
        :direction => "out",
        :status => "pending",
        :to => "someone@desk.com",
        :from => "someone-else@desk.com",
        :cc => "alpha@desk.com",
        :bcc => "beta@desk.com",
        :subject => "Creating a case via the API",
        :body => "Please assist me with this case",
        :created_at => "2012-05-02T21:38:48Z"
      }
    } do
      let(:check_value) { "Creating a case via the API" }
    end

    it_behaves_like "an update endpoint", {
      :subject => "Updated",
      :status => "pending",
      :labels => [ "Spam", "Test" ],
      :label_action => "replace",
      :custom_fields => { :level => "super" },
      :_links => {
        :assigned_group => {
          :href => "/api/v2/groups/1",
          :rel => "group"
        }
      }
    } do
      let(:check_value) { "Updated" }
    end

    context "Message" do

      let(:sub_endpoint) { "message" }
      let(:check_value) { "Please help" }

      include_context "plural endpoint"

      subject { client.send("show_#{endpoint}_#{sub_endpoint}", id) }

      before do
        stub_get("#{endpoints}/#{id}/#{sub_endpoint}").
          to_return(:body => fixture("#{endpoint}_#{sub_endpoint}"))
      end

      it "gets the correct resource" do
        subject
        expect(a_get("#{endpoints}/#{id}/#{sub_endpoint}")).
          to have_been_made
      end

      it { expect(subject).to be_a Hashie::Deash }

      it "has a valid entry" do
        expect(subject.parent_id).to eq(id)
        expect(subject.send(check_key)).to eq(check_value)
      end

      it "allows raw access" do
        expect(subject.raw).to be_a Hashie::Deash
      end

    end

    context "Reply" do

      let(:sub_endpoint) { "reply" }
      let(:sub_id) { 1 }
      let(:check_key) { "subject" }
      let(:check_value) { "Re: Please help" }

      it_behaves_like "a sub list endpoint" do
        let(:check_value) { "Please help" }
      end

      it_behaves_like "a sub show endpoint" do
        let(:sub_id) { 2 }
      end

      it_behaves_like "a sub create endpoint", {
        :body => "My Reply",
        :direction => "out"
      }

      it_behaves_like "a sub update endpoint", {
        :body => "Updated reply body",
        :cc => "new.email@example.com"
      }

    end

    context "Note" do

      let(:sub_endpoint) { "note" }
      let(:sub_id) { 1 }
      let(:check_key) { "body" }
      let(:check_value) { "Please assist me with this case" }

      it_behaves_like "a sub list endpoint"

      it_behaves_like "a sub show endpoint"

      it_behaves_like "a sub create endpoint", {
        :body => "Help me with my issue!"
      } do
        let(:check_value) { "Help me with my issue!" }
      end

    end

    context "Attachment" do

      let(:sub_endpoint) { "attachment" }
      let(:sub_id) { 1 }
      let(:check_key) { "file_name" }
      let(:check_value) { "awesome_pic.png" }

      it_behaves_like "a sub list endpoint"

      it_behaves_like "a sub show endpoint"

      it_behaves_like "a sub create endpoint", {
        :file_name => "awesome_pic.png",
        :content_type => "image/png",
        :content => "iVBORw0KGgoAAAANSUhEUgAAABsAAAAXCAIAAAB1dKN5AAAAGXRFWHRTb2Z0
          d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyRpVFh0WE1MOmNvbS5hZG9i
          ZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2Vo
          aUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6
          bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2
          LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpS
          REYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJk
          Zi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIg
          eG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxu
          czp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1s
          bnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9S
          ZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9w
          IENTNiAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo0
          NkEyOEM5RUE2REUxMUUyODc1NUM1OUZGMTlFMjEwNyIgeG1wTU06RG9jdW1l
          bnRJRD0ieG1wLmRpZDo0NkEyOEM5RkE2REUxMUUyODc1NUM1OUZGMTlFMjEw
          NyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAu
          aWlkOjg5ODY1RDg5QTZENzExRTI4NzU1QzU5RkYxOUUyMTA3IiBzdFJlZjpk
          b2N1bWVudElEPSJ4bXAuZGlkOjg5ODY1RDhBQTZENzExRTI4NzU1QzU5RkYx
          OUUyMTA3Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4
          bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+I+v80gAAAwJJREFUeNqklUtr
          U0EUx2fuvb1pmvSVmvpA2021tMXWoiLiY6MoFHQhgvYTFBTpZ+jChXHjwo3g
          Uhe6EAuCoC1uRKVRulBbUFNSWvrC2rTN475mjmdmkkuSpg/t5SaczNzzu//z
          PzMTAwDI/14MCAficrAYyTHIepBlRNsVjhCPEw/E7XLiyu9/IELhZjITWTmb
          x98l3jwdtxk4HFxJN3YCUhcWCFIXBgiNj/x89ehTOpVrO3moh4HFiS1kgrET
          HOcCxGTABA5QS+LbAuJU+TkmcEqmsVWN0nglylMgUSyIqmXhvqG5Ag7HjLLS
          FEWNqOokDqT3IkeaBaobvhsWEyOUkN5G3YANHimWVCdEKWmO9KhAVM0BXyPO
          Npq0q14L6tRAa0B5BPmK8tIIMC7GJU5ALZf/WVh3HFYdCRkh09doauR4RI+Y
          VP00vAJLvdwtgjIJxcHV5Wz82fjU+4SbczFH02hL1z5S2Bp1VdTHCaLLQNns
          5G0SjqiqUSAS5yYXR2Mj9rrl53AOya/zm7XUwH2DFEcSHSaaiMaxgptrS+nR
          2Ft73d75RkAioEwb3ZVondKATlecPPTLk7iPO3el4/zVzpqw+X1sZvhxPLPJ
          awzc3o7soFgcQDrrtWiAIiuD2z7tvPg8rZ67dLPn2sApFSO3tT1679ZLziuc
          MlpGHBvE4oCLfk9A4HAUP2GDppLLzBPrmFJ6ub+nOA2JHScOVtaoFifW2Byg
          KLB4LpdxVBAIGqG66rLMyN5wHmHqJRptJpbB4bDW3aDT0pzahqAKrKz7e36t
          jDibWFZBYzRUQmyr1c5GjdZQhWOtpT0aDJkqfv7wI2fcn8K2JCeXVHzk2IHi
          LP3B3aFybf7bNJpOWVMTixgvzqxOxGex/Uuzqx9e//BwfQBZmE5FmsM3Bs/g
          k34W3fpfwco6sdvDc8mVyq/UtcH7fe29JRq3OcOra8w7sT7sbKWpqoGhi2W4
          7TXmtx3jWOnY6C/shmt7Tftru0+3Xrh+tL6pZuPDdDf/hRWvvwIMAJE9J8AO
          RSMOAAAAAElFTkSuQmCC"
      }

      it_behaves_like "a sub delete endpoint"

    end
  end
end
