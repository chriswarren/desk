require 'helper'

shared_examples_for "a list endpoint" do

  include_context "plural endpoint"

  subject { client.send("list_#{endpoints}") }

  before do
    stub_get(endpoints).to_return(:body => fixture(endpoints))
  end

  it "gets the correct resource" do
    subject
    expect(a_get(endpoints)).to have_been_made
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

shared_examples_for "a show endpoint" do

  include_context "plural endpoint"

  subject { client.send("show_#{endpoint}", id) }

  before do
    stub_get("#{endpoints}/#{id}").to_return(:body => fixture(endpoint))
  end

  it "gets the correct resource" do
    subject
    expect(a_get("#{endpoints}/#{id}")).to have_been_made
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

shared_examples_for "a create endpoint" do |args|

  include_context "plural endpoint"

  subject { client.send("create_#{endpoint}", args) }

  before do
    stub_post("#{endpoints}").to_return(:body => fixture("#{endpoint}_create"))
  end

  it "gets the correct resource" do
    subject
    expect(a_post(endpoints)).to have_been_made
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

shared_examples_for "an update endpoint" do |args|

  include_context "plural endpoint"

  subject { client.send("update_#{endpoint}", id, args) }

  before do
    stub_patch("#{endpoints}/#{id}").
      to_return(:body => fixture("#{endpoint}_update"))
  end

  it "gets the correct resource" do
    subject
    expect(a_patch("#{endpoints}/#{id}")).to have_been_made
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

shared_examples_for "a delete endpoint" do

  include_context "plural endpoint"

  subject { client.send("delete_#{endpoint}", id) }

  before do
    stub_delete("#{endpoints}/#{id}").to_return(:body => nil)
  end

  it "gets the correct resource" do
    subject
    expect(a_delete("#{endpoints}/#{id}")).to have_been_made
  end

  it "has an empty response" do
    expect(subject).to eq(nil)
  end

end

shared_examples_for "a search endpoint" do |args|

  include_context "plural endpoint"

  subject { client.send("search_#{endpoints}", args) }

  before do
    stub_get("#{endpoints}/search").with(:query => args).
      to_return(:body => fixture("#{endpoints}_search"))
  end

  it "gets the correct resource" do
    subject
    expect(a_get("#{endpoints}/search").with(:query => args)).
      to have_been_made
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

shared_examples_for "a sub list endpoint" do |has_parent_id|

  has_parent_id = true unless has_parent_id === false

  include_context "plural endpoint"

  subject { client.send("list_#{endpoint}_#{sub_endpoints}", id) }

  before do
    stub_get("#{endpoints}/#{id}/#{sub_endpoints}").
      to_return(:body => fixture("#{endpoint}_#{sub_endpoints}"))
  end

  it "gets the correct resource" do
    subject
    expect(a_get("#{endpoints}/#{id}/#{sub_endpoints}")).to have_been_made
  end

  it { expect(subject).to be_a Hashie::Deash }

  it "has valid entries" do
    expect(subject.first.id).to eq(sub_id)
    expect(subject.first.parent_id).to eq(id) if has_parent_id
    expect(subject.first.send(check_key)).to eq(check_value)
  end

  it "allows raw access" do
    expect(subject.raw.first).to be_a Array
  end

end

shared_examples_for "a sub show endpoint" do

  include_context "plural endpoint"

  subject { client.send("show_#{endpoint}_#{sub_endpoint}", id, sub_id) }

  before do
    stub_get("#{endpoints}/#{id}/#{sub_endpoints}/#{sub_id}").
      to_return(:body => fixture("#{endpoint}_#{sub_endpoint}"))
  end

  it "gets the correct resource" do
    subject
    expect(a_get("#{endpoints}/#{id}/#{sub_endpoints}/#{sub_id}")).
      to have_been_made
  end

  it { expect(subject).to be_a Hashie::Deash }

  it "has a valid entry" do
    expect(subject.id).to eq(sub_id)
    expect(subject.parent_id).to eq(id)
    expect(subject.send(check_key)).to eq(check_value)
  end

  it "allows raw access" do
    expect(subject.raw).to be_a Hashie::Deash
  end

end

shared_examples_for "a sub create endpoint" do |args|

  include_context "plural endpoint"

  subject { client.send("create_#{endpoint}_#{sub_endpoint}", id, args) }

  before do
    stub_post("#{endpoints}/#{id}/#{sub_endpoints}").
      to_return(:body => fixture("#{endpoint}_#{sub_endpoint}_create"))
  end

  it "gets the correct resource" do
    subject
    expect(a_post("#{endpoints}/#{id}/#{sub_endpoints}")).to have_been_made
  end

  it { expect(subject).to be_a Hashie::Deash }

  it "has a valid entry" do
    expect(subject.id).to eq(sub_id)
    expect(subject.parent_id).to eq(id)
    expect(subject.send(check_key)).to eq(check_value)
  end

  it "allows raw access" do
    expect(subject.raw).to be_a Hashie::Deash
  end

end

shared_examples_for "a sub update endpoint" do |args|

  include_context "plural endpoint"

  subject { client.send("update_#{endpoint}_#{sub_endpoint}", id, sub_id, args) }

  before do
    stub_patch("#{endpoints}/#{id}/#{sub_endpoints}/#{sub_id}").
      to_return(:body => fixture("#{endpoint}_#{sub_endpoint}_update"))
  end

  it "gets the correct resource" do
    subject
    expect(a_patch("#{endpoints}/#{id}/#{sub_endpoints}/#{sub_id}")).
      to have_been_made
  end

  it { expect(subject).to be_a Hashie::Deash }

  it "has a valid entry" do
    expect(subject.id).to eq(sub_id)
    expect(subject.parent_id).to eq(id)
    expect(subject.send(check_key)).to eq(check_value)
  end

  it "allows raw access" do
    expect(subject.raw).to be_a Hashie::Deash
  end

end

shared_examples_for "a sub delete endpoint" do

  include_context "plural endpoint"

  subject { client.send("delete_#{endpoint}_#{sub_endpoint}", id, sub_id) }

  before do
    stub_delete("#{endpoints}/#{id}/#{sub_endpoints}/#{sub_id}").
      to_return(:body => nil)
  end

  it "gets the correct resource" do
    subject
    expect(a_delete("#{endpoints}/#{id}/#{sub_endpoints}/#{sub_id}")).
      to have_been_made
  end

  it "has an empty response" do
    expect(subject).to eq(nil)
  end

end
