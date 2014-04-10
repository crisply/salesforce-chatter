require "spec_helper"

describe Salesforce::Chatter::Authentication do
  let(:dummy_class) { Class.new {
    include Salesforce::Chatter::Configuration
    include Salesforce::Chatter::Authentication
  }}
  let(:instance)      { dummy_class.new }
  let(:oauth2_client) { double("oauth2_client") }
  let(:access_token)  {
    atok = OAuth2::AccessToken.new nil, "test_token", refresh_token: "test_refresh"
    atok.instance_variable_set :@params, {"instance_url" => "http://myinst.com"}
    atok
  }

  describe "#authenticate_with_user!" do
    let(:password)      { double("password") }

    it "replaces token information on success" do
      password.stub(:get_token) { access_token }
      access_token.refresh_token = nil
      oauth2_client.stub(:password) { password }
      instance.stub(:oauth2_client) { oauth2_client }
      expect(instance.authenticate_with_user!).to be_true
      expect(instance.token).to eql("test_token")
      expect(instance.refresh_token).to be_nil
      expect(instance.endpoint).to eql("http://myinst.com")
    end
  end

  describe "#refresh_token!" do
    it "refreshes with a refresh_token!" do
      oauth2_client.stub(:refresh!) { access_token }
      instance.stub(:oauth2_access_token) { oauth2_client }
      expect(instance.refresh_token!).to be_true
      expect(instance.token).to eql("test_token")
      expect(instance.refresh_token).to eql("test_refresh")
      expect(instance.endpoint).to eql("http://myinst.com")
    end
  end

  describe "#authenticated?" do
    it "#authenticated? is true if the token exists" do
      instance.stub(:token) {"any_token_will_do"}
      expect(instance.authenticated?).to be_true
    end

    it "#authenticated? is false if the token is nil" do
      instance.stub(:token) {nil}
      expect(instance.authenticated?).to be_false
    end

    it "#authenticated? is false if the token is blank" do
      instance.stub(:token) {""}
      expect(instance.authenticated?).to be_false
    end
  end

end
