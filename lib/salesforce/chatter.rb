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
  end
end
