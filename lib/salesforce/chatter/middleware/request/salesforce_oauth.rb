module Salesforce::Chatter::Middleware
  module Request
    class SalesforceOAuth < ::Faraday::Middleware
      def call(env)
        if options.has_key?(:token)
          env.request_headers["Authorization"] = "OAuth #{options[:token]}"
        end

        @app.call(env)
      end

      attr_reader :options

      def initialize(app, options)
        @app, @options = app, options
      end
    end
  end
end
