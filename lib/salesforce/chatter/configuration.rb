module Salesforce::Chatter
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {Salesforce::Chatter::API}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :client_id,
      :client_secret,
      :endpoint,
      :format,
      :token,
      :refresh_token,
      :proxy,
      :username,
      :password,
      :security_token,
      :user_agent,
      :chatter_version,
    ].freeze

    # An array of valid request/response formats
    #
    # @note Not all methods support the XML format.
    VALID_FORMATS = [
      :json,
      :xml].freeze

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set an application key
    DEFAULT_CLIENT_KEY = nil

    # By default, don't set an application secret
    DEFAULT_CLIENT_SECRET = nil

    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = 'https://login.salesforce.com/'.freeze
    AUTHORIZE_PATH   = "/services/oauth2/authorize".freeze
    TOKEN_PATH       = "/services/oauth2/token".freeze
    DEFAULT_CHATTER_VERSION = "/services/data/v30.0".freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is preferred over XML because it is more concise and faster to parse.
    DEFAULT_FORMAT = :json

    # By default, don't set a user oauth token
    DEFAULT_OAUTH_TOKEN = nil

    # By default, don't set a user oauth secret
    DEFAULT_OAUTH_REFRESH_TOKEN = nil

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Salesforce::Chatter Ruby Gem #{Salesforce::Chatter::VERSION}".freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k) }
      options
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter             = DEFAULT_ADAPTER
      self.client_id           = DEFAULT_CLIENT_KEY
      self.client_secret       = DEFAULT_CLIENT_SECRET
      self.endpoint            = DEFAULT_ENDPOINT
      self.format              = DEFAULT_FORMAT
      self.token               = DEFAULT_OAUTH_TOKEN
      self.refresh_token       = DEFAULT_OAUTH_REFRESH_TOKEN
      self.proxy               = DEFAULT_PROXY
      self.user_agent          = DEFAULT_USER_AGENT
      self.chatter_version     = DEFAULT_CHATTER_VERSION
      self
    end
  end
end
