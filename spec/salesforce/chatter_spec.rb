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

  end

end
