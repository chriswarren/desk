require 'helper'

describe Desk::Client do
  Desk::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".topics" do

        context "lookup" do

          before do
            stub_get("topics.#{format}").
              to_return(:body => fixture("topics.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.topics
            a_get("topics.#{format}").
              should have_been_made
          end

          it "should return up to 100 topics worth of extended information" do
            topics = @client.topics

            topics.results.should be_a Array
            topics.results.first.topic.id.should == 1
          end

        end
      end

      describe ".topic" do

        context "lookup" do

          before do
            stub_get("topics/1.#{format}").
              to_return(:body => fixture("topic.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.topic(1)
            a_get("topics/1.#{format}").
              should have_been_made
          end

          it "should return up to 100 cases worth of extended information" do
            topic = @client.topic(1)

            topic.id.should == 1
            topic.name.should == "General"
          end

        end
      end

      describe ".create_topic" do

        context "create" do

          before do
            stub_post("topics.#{format}").
              to_return(:body => fixture("topic_create.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should post to the correct resource" do
            @client.create_topic("General", :description => "Everything belongs here")
            a_post("topics.#{format}").
              should have_been_made
          end

          it "should return the new topic" do
            topic = @client.create_topic("General", :description => "Everything belongs here")

            topic.id.should == 9
            topic.name.should == "General"
            topic.description.should == "Everything belongs here"
          end

        end
      end

      describe ".update_topic" do

        context "update" do

          before do
            stub_put("topics/1.#{format}").
              to_return(:body => fixture("topic_update.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should post to the correct resource" do
            @client.update_topic(1, :name => "Updated", :description => "Updated Description")
            a_put("topics/1.#{format}").
              should have_been_made
          end

          it "should return the new topic" do
            topic = @client.update_topic(1, :name => "Updated", :description => "Updated Description")

            topic.name.should == "Updated"
            topic.description.should == "Updated Description"
          end

        end
      end

      describe ".delete_topic" do

        context "delete" do

          before do
            stub_delete("topics/1.#{format}").
              to_return(:body => fixture("topic_destroy.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should post to the correct resource" do
            @client.delete_topic(1)
            a_delete("topics/1.#{format}").
              should have_been_made
          end

          it "should return a successful response" do
            topic = @client.delete_topic(1)
            topic.success.should == true
          end

        end
      end
    end
  end
end
