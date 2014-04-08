# @private
module Salesforce::Chatter::Middleware
  module Response
    # @private
    class RaiseHttp5xx < ::Faraday::Response::Middleware
      def on_complete(env)
        case env[:status].to_i
        when 500
          raise Salesforce::Chatter::InternalServerError.new(error_message(env, "Something is technically wrong."), env[:response_headers])
        when 502
          raise Salesforce::Chatter::BadGateway.new(error_message(env, "Something is technically wrong."), env[:response_headers])
        when 503
          raise Salesforce::Chatter::ServiceUnavailable.new(error_message(env, "Something is technically wrong."), env[:response_headers])
        end
      end

      private

      def error_message(env, body=nil)
        "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{[env[:status].to_s + ':', body].compact.join(' ')} Check https://trust.salesforce.com/trust/status/ for updates on the status of the Salesforce API services."
      end
    end
  end
end
