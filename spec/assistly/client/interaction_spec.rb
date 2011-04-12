require 'helper'

describe Assistly::Client do
  Assistly::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Assistly::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".create_interaction" do
        context "create a new interaction" do
          before do
            stub_post("interactions.#{format}").
              to_return(:body => fixture("interaction_create.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.create_interaction(:interaction_subject => "this is an api test", :customer_email => "customer@zencoder.com")
            a_post("interactions.#{format}").
              should have_been_made
          end

          it "should create an interaction" do
            interaction = @client.create_interaction(:interaction_subject => "this is an api test", :customer_email => "customer@zencoder.com")

            interaction.customer.emails.first.email.email.should == "customer@zencoder.com"
            interaction.interaction.interactionable.email.subject.should == "this is an api test"
          end
        end
      end

      describe ".interactions" do

        context "lookup" do

          before do
            stub_get("interactions.#{format}").
              to_return(:body => fixture("interactions.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.interactions
            a_get("interactions.#{format}").
              should have_been_made
          end

          it "should return up to 100 users worth of extended information" do
            interactions = @client.interactions
            
            interactions.should be_a Array
            interactions.last.interaction.user.name.should == "Agent Jeremy"
          end

        end
      end
    end
  end
end
