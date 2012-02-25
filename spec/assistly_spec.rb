require 'helper'

describe Assistly do
  after do
    Assistly.reset
  end

  # context "when delegating to a client" do
  # 
  #   before do
  #     stub_get("statuses/user_timeline.json").
  #       with(:query => {:screen_name => "sferik"}).
  #       to_return(:body => fixture("statuses.json"), :headers => {:content_type => "application/json; charset=utf-8"})
  #   end
  # 
  #   it "should get the correct resource" do
  #     Twitter.user_timeline('sferik')
  #     a_get("statuses/user_timeline.json").
  #       with(:query => {:screen_name => "sferik"}).
  #       should have_been_made
  #   end
  # 
  #   it "should return the same results as a client" do
  #     Assistly.user_timeline('sferik').should == Twitter::Client.new.user_timeline('sferik')
  #   end
  # 
  # end

  describe ".client" do
    it "should be an Assistly::Client" do
      Assistly.client.should be_a Assistly::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      Assistly.adapter.should == Assistly::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Assistly.adapter = :typhoeus
      Assistly.adapter.should == :typhoeus
    end
  end
  
  describe ".subdomain=" do
    before do
      Assistly.subdomain = "zencoder"
    end
    
    it "should set the subdomain" do
      Assistly.subdomain.should == "zencoder"
    end
    
    it "should change the endpoint" do
      Assistly.endpoint.should == "https://zencoder.desk.com/api/#{Assistly::Configuration::DEFAULT_VERSION}/"
    end
  end
  
  describe ".support_email" do
    it "should return the default support_email" do
      Assistly.support_email.should == Assistly::Configuration::DEFAULT_SUPPORT_EMAIL
    end
  end

  describe ".support_email=" do
    it "should set the support_email" do
      Assistly.support_email = "help@example.com"
      Assistly.support_email.should == "help@example.com"
    end
  end
  
  describe ".version=" do
    before do
      Assistly.version = "v4"
    end
    
    it "should set the subdomain" do
      Assistly.version.should == "v4"
    end
    
    it "should change the endpoint" do
      Assistly.endpoint.should == "https://#{Assistly::Configuration::DEFAULT_SUBDOMAIN}.desk.com/api/v4/"
    end
  end

  describe ".format" do
    it "should return the default format" do
      Assistly.format.should == Assistly::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      Assistly.format = 'xml'
      Assistly.format.should == 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Assistly.user_agent.should == Assistly::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Assistly.user_agent = 'Custom User Agent'
      Assistly.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do

    Assistly::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Assistly.configure do |config|
          config.send("#{key}=", key)
          Assistly.send(key).should == key
        end
      end
    end
  end
end
