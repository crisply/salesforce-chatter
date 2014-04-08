module Faraday
  class Request::SalesforceOAuth < Faraday::Middleware
    dependency 'simple_oauth'

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

Faraday::Middleware.register_middleware salesforce_oauth: Faraday::Request::SalesforceOAuth
