module Salesforce::Chatter
  module Middleware
  end
end

require 'salesforce/chatter/middleware/request/salesforce_oauth'
require 'salesforce/chatter/middleware/response/raise_http_4xx'
require 'salesforce/chatter/middleware/response/raise_http_5xx'

Faraday::Middleware.register_middleware salesforce_oauth: Salesforce::Chatter::Middleware::Request::SalesforceOAuth
Faraday::Middleware.register_middleware raise_http_4xx: Salesforce::Chatter::Middleware::Response::RaiseHttp4xx
Faraday::Middleware.register_middleware raise_http_5xx: Salesforce::Chatter::Middleware::Response::RaiseHttp5xx
