# @private
module Salesforce::Chatter::Middleware
  module Response
    # @private
    class ParseJson < ::Faraday::Response::Middleware
      dependency("json") unless defined?(::JSON)

      # Attempt to parse the body. If it fails just return the original body.
      def parse(body)
        begin
          body.strip.empty? ? {} : JSON.parse(body)
        rescue JSON::ParserError
          body
        end
      end

      def parse_body?
        true
      end

    end
  end
end
