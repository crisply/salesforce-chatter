module Salesforce::Chatter

  class Client < API
    require 'salesforce/chatter/client/feed_items'
    alias :api_endpoint :endpoint
    include Salesforce::Chatter::Client::FeedItems
  end

end
