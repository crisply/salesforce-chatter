require 'faraday/request/salesforce_oauth'
require 'faraday/response/raise_http_4xx'
require 'faraday/response/raise_http_5xx'

module Salesforce::Chatter
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {'Accept' => "application/#{format}", 'User-Agent' => user_agent},
        :proxy => proxy,
        :ssl => {:verify => false},
        :url => api_endpoint,
      }

      Faraday.new(options) do |builder|
        builder.use :salesforce_oauth, authentication if authenticated?
        builder.request :multipart
        builder.request :url_encoded
        builder.response :logger
        builder.use :raise_http_4xx
        builder.use :raise_http_5xx

=begin
        builder.use Faraday::Response::Mashify unless raw
        unless raw
          case format.to_s.downcase
          when 'json'
            builder.use Faraday::Response::ParseJson
          when 'xml'
            builder.use Faraday::Response::ParseXml
          end
        end
=end
        builder.adapter(adapter)
      end
    end
  end
end
