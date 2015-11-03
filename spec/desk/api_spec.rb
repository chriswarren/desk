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
          :max_requests => 50,
          :proxy => 'http://erik:sekret@proxy.example.com:8080',
          :subdomain => 'zencoder',
          :support_email => 'help@zencoder.com',
          :use_max_requests => true,
          :user_agent => 'Custom User Agent',
          :version => "amazing",
          :logger => double('logger')
        }

        @alternative_configuration = {
          :consumer_key => 'Louie',
          :consumer_secret => 'CounterStrike',
          :oauth_token => 'plOT',
          :oauth_token_secret => 'OperatingSystem',
          :adapter => :sueohpyt,
          :format => :json,
          :max_requests => 5,
          :proxy => 'http://tsuk:public@proxy.example.com:8080',
          :subdomain => 'stresscoder',
          :support_email => 'problem@stresscoder.com',
          :use_max_requests => false,
          :user_agent => 'Generic User Agent',
          :version => "boring",
          :logger => double('logger')
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

        it 'should keep different configurations for each thread' do
          Thread.new do
            api = Desk::API.new
            @configuration.each do |key, value|
              api.send("#{key}=", value)
            end

            Thread.new do
              alt_api = Desk::API.new
              @alternative_configuration.each do |key, value|
                alt_api.send("#{key}=", value)
              end
            end.join

            @configuration.each do |key, value|
              api.send(key).should eq(value)
            end
          end.join
        end
      end
    end
  end
end
