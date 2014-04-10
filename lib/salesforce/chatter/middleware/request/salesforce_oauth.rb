module Salesforce::Chatter::Middleware
  module Request
    class SalesforceOAuth < ::Faraday::Middleware
      attr_reader :client

      def initialize(app, client)
        @app, @client = app, client
      end

      def call(env)
        if client.token
          env.request_headers["Authorization"] = "OAuth #{client.token}"
        end
        @app.call(env)
      end

    end
  end
end
