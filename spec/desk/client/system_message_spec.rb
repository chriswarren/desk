require 'helper'

describe Desk::Client do
  context "System Message" do

    let(:endpoint) { "system_message" }
    let(:id) { nil }
    let(:check_key) { "updated_at" }
    let(:check_value) { "2013-11-22T22:49:20Z" }

    include_context "basic configuration"

    context "the current message" do

      include_context "plural endpoint"

      subject { client.send("show_#{endpoint}") }

      before do
        stub_get("#{endpoint}").to_return(:body => fixture(endpoint))
      end

      it "gets the correct resource" do
        subject
        expect(a_get("#{endpoint}")).to have_been_made
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
