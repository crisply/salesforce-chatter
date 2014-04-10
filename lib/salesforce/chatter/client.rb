require 'salesforce/chatter/connection'
require 'salesforce/chatter/request'
require 'salesforce/chatter/authentication'

require 'salesforce/chatter/api/feed_items'

module Salesforce::Chatter

  class Client
    include Connection
    include Request
    include Authentication

    include Salesforce::Chatter::API::FeedItems

    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options={})
      options = Salesforce::Chatter.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
  end

end
