require "spec_helper"

describe Salesforce::Chatter::Middleware::Response::ParseJson do

  it "parses a JSON formatted body" do
    test = Faraday.new do |builder|
      builder.use :parse_json
      builder.adapter :test do |stub|
        stub.get('/test') {[ 200, {}, '{"message":"test body","errors":{"error_one":"test error one"}}' ]}
      end
    end

    resp = test.get "/test"
    expect(resp.body).to be_instance_of(Hash)
    expect(resp.body["message"]).to eql("test body")
    expect(resp.body["errors"]["error_one"]).to eql("test error one")
  end

  it "returns a blank Hash on an empty body" do
    test = Faraday.new do |builder|
      builder.use :parse_json
      builder.adapter :test do |stub|
        stub.get('/test') {[ 200, {}, "" ]}
      end
    end

    resp = test.get "/test"
    expect(resp.body).to be_instance_of(Hash)
    expect(resp.body.empty?).to be_true
  end

  it "returns the original body if the JSON parsing fails" do
    body = "<html><body>API Failure</body></html>"
    test = Faraday.new do |builder|
      builder.use :parse_json
      builder.adapter :test do |stub|
        stub.get('/test') {[ 200, {}, body]}
      end
    end

    resp = test.get "/test"
    expect(resp.body).to be_instance_of(String)
    expect(resp.body).to eql(body)
  end

end
