require 'helper'

describe Desk::API do
  before do
    @keys = Desk::Configuration::VALID_OPTIONS_KEYS
  end

  context "with module configuration" do

    before do
      Desk.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Desk.reset
    end

    it "should inherit module configuration" do
      api = Desk::API.new
      @keys.each do |key|
        api.send(key).should == key
      end
    end

    context "with class configuration" do

      before do
        @configuration = {
          :consumer_key => 'CK',
          :consumer_secret => 'CS',
          :oauth_token => 'OT',
          :oauth_token_secret => 'OS',
          :adapter => :typhoeus,
          :format => :xml,
          :proxy => 'http://erik:sekret@proxy.example.com:8080',
          :subdomain => 'zencoder',
          :support_email => 'help@zencoder.com',
          :user_agent => 'Custom User Agent',
          :version => "amazing"
        }
      end

      context "during initialization"

        it "should override module configuration" do
          api = Desk::API.new(@configuration)
          @keys.each do |key|
            api.send(key).should == @configuration[key]
          end
        end

      context "after initilization" do

        it "should override module configuration after initialization" do
          api = Desk::API.new
          @configuration.each do |key, value|
            api.send("#{key}=", value)
          end
          @keys.each do |key|
            api.send(key).should == @configuration[key]
          end
        end
      end
    end
  end
end
