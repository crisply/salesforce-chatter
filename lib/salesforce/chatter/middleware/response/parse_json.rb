# @private
module Salesforce::Chatter::Middleware
  module Response
    # @private
    class ParseJson < ::Faraday::Response::Middleware
      dependency("json") unless defined?(::JSON)
      dependency("hashie") unless defined?(::Hashie)

      def on_complete(env)
        env.body = parse(env.body, (env.status >= 400))
      end

      # Attempt to parse the body. If it fails just return the original body.
      def parse(body, error = false)
        begin
          body = body.strip.empty? ? {} : JSON.parse(body)
          if body.is_a?(Hash)
            Hashie::Mash.new(body)
          elsif body.is_a?(Array) && error
            Hashie::Mash.new({errors: body})
          else
            body
          end
        rescue JSON::ParserError
          body
        end
      end

    end
  end
end
