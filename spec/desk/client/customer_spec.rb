require 'helper'

describe Desk::Client do
  Desk::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".customers" do

        context "lookup" do

          before do
            stub_get("customers.#{format}").
              to_return(:body => fixture("customers.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.customers
            a_get("customers.#{format}").
              should have_been_made
          end

          it "should return up to 100 customers worth of extended information" do
            customers = @client.customers

            customers.results.should be_a Array
            customers.results.first.customer.first_name.should == "Jeremy"
          end

        end
      end

      describe ".customer" do

        context "lookup" do

          before do
            stub_get("customers/1.#{format}").
              to_return(:body => fixture("customer.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.customer(1)
            a_get("customers/1.#{format}").
              should have_been_made
          end

          it "should return up to 100 customers worth of extended information" do
            customer = @client.customer(1)

            customer.first_name.should == "Jeremy"
            customer.addresses.first.address.city.should == "Commack"
          end

        end
      end

      describe ".create_customer" do

        context "create" do

          before do
            stub_post("customers.#{format}").
              to_return(:body => fixture("customer_create.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.create_customer(:name => "Chris Warren", :twitter => "cdwarren")
            a_post("customers.#{format}").
              should have_been_made
          end

          it "should return the information about this user" do
            customer = @client.create_customer(:name => "John Smith", :twitter => "cdwarren")

            customer.first_name.should == "John"
            customer.phones.first.phone.phone.should == "123-456-7890"
          end

        end
      end

      describe ".update_customer" do

        context "update" do

          before do
            stub_put("customers/1.#{format}").
              to_return(:body => fixture("customer_update.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.update_customer(1, :name => "Chris Warren", :twitter => "cdwarren")
            a_put("customers/1.#{format}").
              should have_been_made
          end

          it "should return the information about this user" do
            customer = @client.update_customer(1, :name => "Joslyn Esser")

            customer.first_name.should == "Joslyn"
          end

        end
      end

      describe ".create_customer_email" do

        context "create" do

          before do
            stub_post("customers/1/emails.#{format}").
              to_return(:body => fixture("customer_create_email.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.create_customer_email(1, :email => "foo@example.com")
            a_post("customers/1/emails.#{format}").
              should have_been_made
          end

          it "should return the information about this user" do
            email = @client.create_customer_email(1, :email => "api@example.com")

            email.email.should == "api@example.com"
          end

        end
      end

      describe ".update_customer_email" do

        context "update" do

          before do
            stub_put("customers/1/emails/2.#{format}").
              to_return(:body => fixture("customer_update_email.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.update_customer_email(1, 2, :email => "foo@example.com")
            a_put("customers/1/emails/2.#{format}").
              should have_been_made
          end

          it "should return the information about this user" do
            email = @client.update_customer_email(1, 2, :email => "api@example.com")

            email.email.should == "api@example.com"
          end

        end
      end
    end
  end
end
