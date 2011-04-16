require 'helper'

describe Assistly::Client do
  Assistly::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Assistly::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".macros" do

        context "lookup" do

          before do
            stub_get("macros.#{format}").
              to_return(:body => fixture("macros.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.macros
            a_get("macros.#{format}").
              should have_been_made
          end

          it "should return up to 100 macros worth of extended information" do
            macros = @client.macros

            macros.should be_a Array
            macros.first.macro.id.should == 11
          end

        end
      end

      describe ".macro" do

        context "lookup" do

          before do
            stub_get("macros/13.#{format}").
              to_return(:body => fixture("macro.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.macro(13)
            a_get("macros/13.#{format}").
              should have_been_made
          end

          it "should return up to 100 cases worth of extended information" do
            macro = @client.macro(13)

            macro.id.should == 13
            macro.name.should == "API Macro"
          end

        end
      end

      describe ".create_macro" do

        context "create" do

          before do
            stub_post("macros.#{format}").
              to_return(:body => fixture("macro_create.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should post to the correct resource" do
            @client.create_macro("API Macro", :description => "Everything belongs here")
            a_post("macros.#{format}").
              should have_been_made
          end

          it "should return the new macro" do
            macro = @client.create_macro("API Macro", :description => "Everything belongs here")

            macro.id.should == 12
            macro.name.should == "API Macro"
          end

        end
      end

      describe ".update_macro" do

        context "update" do

          before do
            stub_put("macros/13.#{format}").
              to_return(:body => fixture("macro_update.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should post to the correct resource" do
            @client.update_macro(13, :name => "Updated")
            a_put("macros/13.#{format}").
              should have_been_made
          end

          it "should return the new macro" do
            macro = @client.update_macro(13, :name => "Updated")

            macro.name.should == "Updated"
          end

        end
      end

      describe ".delete_macro" do

        context "delete" do

          before do
            stub_delete("macros/1.#{format}").
              to_return(:body => fixture("macro_destroy.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should post to the correct resource" do
            @client.delete_macro(1)
            a_delete("macros/1.#{format}").
              should have_been_made
          end

          it "should return a successful response" do
            macro = @client.delete_macro(1)
            macro.success.should == true
          end

        end
      end
    end
  end
end
