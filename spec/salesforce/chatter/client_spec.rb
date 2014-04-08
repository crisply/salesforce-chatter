require "spec_helper"

describe Salesforce::Chatter::Client do

  it "responds to Configuration options" do
    options = %i{adapter consumer_key consumer_secret endpoint format
      gateway oauth_token oauth_refresh_token proxy username
      password security_token user_agent chatter_version}

    options.each do |opt|
      expect { subject.respond_to?(opt) }.to be_true
    end
  end

end
