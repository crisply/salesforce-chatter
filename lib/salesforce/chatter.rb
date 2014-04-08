require 'yajl'
require 'hashie'
require 'simple_oauth'
require 'faraday'

require 'salesforce/chatter/version'
require 'salesforce/chatter/errors'
require 'salesforce/chatter/configuration'
require 'salesforce/chatter/api'
require 'salesforce/chatter/client'

module Salesforce
  module Chatter
    extend Configuration

    # Alias for Salesforce::Chatter::Client.new
    #
    # @return [Salesforce::Chatter::Client]
    def self.new(options={})
      Client.new(options)
    end

    # Delegate to Salesforce::Chatter::Client
    def self.method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def self.respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
