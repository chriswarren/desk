require 'helper'

describe Desk::Client do
  Desk::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".cases" do

        context "lookup" do

          before do
            stub_get("cases.#{format}").
              to_return(:body => fixture("cases.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.cases
            a_get("cases.#{format}").
              should have_been_made
          end

          it "should return up to 100 cases worth of extended information" do
            cases = @client.cases

            cases.results.should be_a Array
            cases.results.first.case.id.should == 1
            cases.results.first.case.user.name.should == "Jeremy Suriel"
          end

        end
      end

      describe ".case" do

        context "lookup" do

          before do
            stub_get("cases/1.#{format}").
              to_return(:body => fixture("case.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.case(1)
            a_get("cases/1.#{format}").
              should have_been_made
          end

          it "should return up to 100 cases worth of extended information" do
            a_case = @client.case(1)

            a_case.id.should == 1
            a_case.external_id.should == "123"
            a_case.subject.should == "Welcome to Desk.com"
          end

        end
      end

      describe ".update_case" do

        context "update" do

          before do
            stub_put("cases/1.#{format}").
              to_return(:body => fixture("case_update.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.update_case(1, :subject => "Welcome to Desk")
            a_put("cases/1.#{format}").
              should have_been_made
          end

          it "should return up to 100 cases worth of extended information" do
            a_case = @client.update_case(1, :subject => "Welcome to Desk.com")

            a_case.id.should == 1
            a_case.subject.should == "Welcome to Desk.com"
          end

        end
      end

      describe ".case_url" do

        context "generating a case url" do

          it "should make a correct url for the case" do
            @client.case_url(123).should == "https://example.desk.com/agent/case/123"
          end

        end
      end
    end
  end
end
