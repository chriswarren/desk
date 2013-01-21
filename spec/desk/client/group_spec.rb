require 'helper'

describe Desk::Client do
  Desk::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".groups" do

        context "lookup" do

          before do
            stub_get("groups.#{format}").
              to_return(:body => fixture("groups.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.groups
            a_get("groups.#{format}").
              should have_been_made
          end

          it "should return up to 100 groups worth of extended information" do
            groups = @client.groups

            groups.results.should be_a Array
            groups.results.last.group.id.should == 2
            groups.results.last.group.name.should == "Supervisor"
          end

        end
      end

      describe ".group" do

        context "lookup" do

          before do
            stub_get("groups/1.#{format}").
              to_return(:body => fixture("group.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.group(1)
            a_get("groups/1.#{format}").
              should have_been_made
          end

          it "should return up to 100 cases worth of extended information" do
            group = @client.group(1)

            group.id.should == 1
            group.name.should == "General"
          end

        end
      end
      
    end
  end
end