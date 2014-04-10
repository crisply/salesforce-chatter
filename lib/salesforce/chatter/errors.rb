module Salesforce::Chatter
  class Error < ::Exception; end

  class AuthenticationError < Error; end

  class HTTPError < Error
    attr_reader :response_headers

    def initialize(message, response_headers)
      super(message)
      @response_headers = response_headers
    end
  end

  class HTTP4xxError < HTTPError; end
  class BadRequest < HTTP4xxError; end
  class Unauthorized < HTTP4xxError; end
  class Forbidden < HTTP4xxError; end
  class NotFound < HTTP4xxError; end
  class NotAcceptable < HTTP4xxError; end
  class EnhanceYourCalm < HTTP4xxError; end

  class HTTP5xxError < HTTPError; end
  class InternalServerError < HTTP5xxError; end
  class BadGateway < HTTP5xxError; end
  class ServiceUnavailable < HTTP5xxError; end

end
