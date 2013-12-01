require 'helper'

describe Desk::Client do
  context "Inbound Mailbox" do

    let(:endpoint) { "inbound_mailbox" }
    let(:id) { 1 }
    let(:check_key) { "name" }
    let(:check_value) { "Support Mailbox" }

    include_context "basic configuration"

    context "list all inbound mailboxes" do

      include_context "plural endpoint"

      subject { client.send("list_#{endpoints}") }

      before do
        stub_get("mailboxes/inbound").to_return(:body => fixture(endpoints))
      end

      it "gets the correct resource" do
        subject
        expect(a_get("mailboxes/inbound")).to have_been_made
      end

      it { expect(subject).to be_a Hashie::Deash }

      it "has valid entries" do
        expect(subject.first.id).to eq(id)
        expect(subject.first.send(check_key)).to eq(check_value)
      end

      it "allows raw access" do
        expect(subject.raw.first).to be_a Array
      end

    end

    context "retrieve a single inbound mailbox" do

      include_context "plural endpoint"

      subject { client.send("show_#{endpoint}", id) }

      before do
        stub_get("mailboxes/inbound/#{id}").to_return(:body => fixture(endpoint))
      end

      it "gets the correct resource" do
        subject
        expect(a_get("mailboxes/inbound/#{id}")).to have_been_made
      end

      it { expect(subject).to be_a Hashie::Deash }

      it "has a valid entry" do
        expect(subject.id).to eq(id)
        expect(subject.send(check_key)).to eq(check_value)
      end

      it "allows raw access" do
        expect(subject.raw).to be_a Hashie::Deash
      end

    end

  end
end
