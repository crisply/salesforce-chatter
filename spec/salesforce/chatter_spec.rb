require "spec_helper"

describe Salesforce::Chatter do

  after do
    Salesforce::Chatter.reset
  end

  describe ".configure" do

    Salesforce::Chatter::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        Salesforce::Chatter.configure do |config|
          config.send("#{key}=", key)
          Salesforce::Chatter.send(key).should == key
        end
      end
    end

    it "should get an oauth token for the user" do
      Salesforce::Chatter.configure do |config|
        config.consumer_key    = ""
        config.consumer_secret = ""
        config.username        = ""
        config.password        = ""
        config.endpoint        = ""
        config.security_token  = ""
      end
      Salesforce::Chatter.authenticate
      Salesforce::Chatter.oauth_token.should_not be_nil
    end

    it "should reset auth token" do
      Salesforce::Chatter.configure do |config|
        config.consumer_key    = ""
        config.consumer_secret = ""
        config.username        = ""
        config.password        = ""
        config.endpoint        = ""
        config.security_token  = ""
      end
      Salesforce::Chatter.authenticate
      Salesforce::Chatter.reset
      Salesforce::Chatter.oauth_token.should == nil
    end

    it "should be able to use an existing auth token" do
      Salesforce::Chatter.configure do |config|
        config.consumer_key    = ""
        config.consumer_secret = ""
        config.username        = ""
        config.password        = ""
        config.endpoint        = ""
        config.security_token  = ""
      end
      Salesforce::Chatter.authenticate
      oauth_token = Salesforce::Chatter.oauth_token
      Salesforce::Chatter.reset

      Salesforce::Chatter.configure do |config|
        config.consumer_key    = ""
        config.consumer_secret = ""
        config.username        = ""
        config.password        = ""
        config.endpoint        = ""
        config.security_token  = ""
        config.oauth_token     = oauth_token
      end

      Salesforce::Chatter.feed_items.class.should == Hashie::Mash
    end
  end

end
