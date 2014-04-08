require 'salesforce/chatter/connection'
require 'salesforce/chatter/request'
require 'salesforce/chatter/authentication'

module Salesforce::Chatter
  class API

    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options={})
      options = Salesforce::Chatter.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Connection
    include Request
    include Authentication
  end
end
