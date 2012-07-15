require 'helper'

describe Desk::Client do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  Desk::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS', :support_email => "help@example.com")
      end

      describe ".create_interaction" do
        context "create a new interaction without specifying direction should default to inbound" do
          before do
            stub_post("interactions.#{format}").
              to_return(:body => fixture("interaction_create.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.create_interaction(:interaction_subject => "this is an api test", :customer_email => "foo@example.com")
            a_post("interactions.#{format}").
              should have_been_made
          end

          it "should create an interaction" do
            interaction = @client.create_interaction(:interaction_subject => "this is an api test", :customer_email => "foo@example.com")

            interaction.customer.emails.first.email.email.should == "customer@zencoder.com"
            interaction.interaction.interactionable.email.subject.should == "this is an api test"
          end
        end

        context "create a new interaction and specify inbound" do
          before do
            stub_post("interactions.#{format}").
              to_return(:body => fixture("interaction_create.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.create_interaction(:interaction_subject => "this is an api test", :customer_email => "foo@example.com", :direction => "in")
            a_post("interactions.#{format}").
              should have_been_made
          end

          it "should create an interaction" do
            interaction = @client.create_interaction(:interaction_subject => "this is an api test", :customer_email => "foo@example.com", :direction => "in")

            interaction.customer.emails.first.email.email.should == "customer@zencoder.com"
            interaction.interaction.interactionable.email.subject.should == "this is an api test"
          end
        end

        context "create a new interaction and specify outbound" do
          before do
            @email = @client.create_interaction(:customer_email => "customer@example.com", :interaction_subject => "Need help?", :interaction_body => "Sorry we missed you in chat today.", :direction => "outbound")
          end

          it "should deliver the email to the customer" do
            @email.last.should deliver_to("customer@example.com")
          end

          it "should be from the support email" do
            @email.last.should deliver_from(@client.support_email)
          end

          it "should contain the message in the mail body" do
            @email.last.should have_body_text(/Sorry we missed you in chat today/)
          end

          it "should bcc to the support email" do
            @email.last.should bcc_to(@client.support_email)
          end

          it "should set the Desk headers" do
            @email.last.should have_header("x-assistly-customer-email","customer@example.com")
            @email.last.should have_header("x-assistly-interaction-direction","out")
            @email.last.should have_header("x-assistly-case-status","open")
          end
        end
      end

      describe ".create_inbound_interaction" do
        context "create a new interaction" do
          before do
            stub_post("interactions.#{format}").
              to_return(:body => fixture("interaction_create.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.create_inbound_interaction(:interaction_subject => "this is an api test", :customer_email => "foo@example.com")
            a_post("interactions.#{format}").
              should have_been_made
          end

          it "should create an interaction" do
            interaction = @client.create_inbound_interaction(:interaction_subject => "this is an api test", :customer_email => "foo@example.com")

            interaction.customer.emails.first.email.email.should == "customer@zencoder.com"
            interaction.interaction.interactionable.email.subject.should == "this is an api test"
          end
        end
      end

      describe ".create_outbound_interaction" do
        context "create" do

          before do
            @email = @client.create_outbound_interaction("customer@example.com", "Need help?", "Sorry we missed you in chat today.")
          end

          it "should deliver the email to the customer" do
            @email.last.should deliver_to("customer@example.com")
          end

          it "should be from the support email" do
            @email.last.should deliver_from(@client.support_email)
          end

          it "should contain the message in the mail body" do
            @email.last.should have_body_text(/Sorry we missed you in chat today/)
          end

          it "should bcc to the support email" do
            @email.last.should bcc_to(@client.support_email)
          end

          it "should set the Assitly headers" do
            @email.last.should have_header("x-assistly-customer-email","customer@example.com")
            @email.last.should have_header("x-assistly-interaction-direction","out")
            @email.last.should have_header("x-assistly-case-status","open")
          end

        end

        context "without support_email defined" do

          before do
            @client_without_support_email = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
          end

          it "should raise an error" do
            lambda do
              @client_without_support_email.create_outbound_interaction("customer@example.com", "Need help?", "Sorry we missed you in chat today.")
            end.should raise_error(Desk::SupportEmailNotSet)
          end

        end

        context "with customer headers set" do
          before do
            @custom_email = @client.create_outbound_interaction("customer@example.com", "Need help?", "Sorry we missed you in chat today.", :headers => { "x-assistly-interaction-user-agent" => "12345"})
          end

          it "should merge the custom headers" do
            @custom_email.last.should have_header("x-assistly-interaction-user-agent","12345")
          end

          it "should preserve the existing headers" do
            @custom_email.last.should have_header("x-assistly-customer-email","customer@example.com")
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

            interactions.results.should be_a Array
            interactions.results.last.interaction.user.name.should == "Agent Jeremy"
          end

        end
      end
    end
  end
end
