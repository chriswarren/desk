require 'helper'

describe Assistly::Client do
  Assistly::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Assistly::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".user" do

        context "with id passed" do

            before do
              stub_get("users/1.#{format}").
                to_return(:body => fixture("user.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
            end

            it "should get the correct resource" do
              @client.user(1)
              a_get("users/1.#{format}").
                should have_been_made
            end

            it "should return extended information of a given user" do
              user = @client.user(1)
              user.name.should == "Chris Warren"
            end

        end
      end

      describe ".users" do

        context "lookup" do

          before do
            stub_get("users.#{format}").
              to_return(:body => fixture("users.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.users
            a_get("users.#{format}").
              should have_been_made
          end

          it "should return up to 100 users worth of extended information" do
            users = @client.users
            users.should be_a Array
            users.first.name.should == "Test User"
          end

        end
      end
    end
  end
end
