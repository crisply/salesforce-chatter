require "salesforce/chatter/middleware"
module Salesforce::Chatter
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {'Accept' => "application/#{format}", 'User-Agent' => user_agent},
        :proxy   => proxy,
        :ssl     => {:verify => false},
        :url     => endpoint,
      }

      Faraday.new(options) do |builder|
        builder.use :salesforce_oauth, self if authenticated?
        builder.request :multipart
        builder.request :url_encoded
        builder.response :logger
        builder.use :raise_http_4xx
        builder.use :parse_json
        builder.use :raise_http_5xx
        builder.adapter(adapter)
      end
    end
  end
end
