module Salesforce::Chatter
  module API
    # Defines methods related to feed items
    module FeedItems

      # @see http://www.salesforce.com/us/developer/docs/chatterapi/Content/connect_resource_feeds_news.htm
      # @param opts [Hash] options for Salesforce
      def my_feed_items(opts = {})
        response = get('/chatter/feeds/news/me/feed-items', opts)
      end

      def my_feed_item_create(text, options={})
        options[:text] = text
        response = post("/chatter/feeds/news/me/feed-items", options)
      end

      def my_feed_is_modified(opts = {})
        response = get("/chatter/feeds/news/me/is-modified", opts)
      end

      def feed_item_destroy(id, options={})
        response = delete("/chatter/feed-items/#{id}", options)
      end

      def feed_item(id, options={})
        response = get("/chatter/feed-items/#{id}", options)
      end
    end
  end
end
