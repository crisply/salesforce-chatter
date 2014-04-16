module Salesforce::Chatter
  module API
    # Defines methods related to feed items
    module FeedItems

      # @see http://www.salesforce.com/us/developer/docs/chatterapi/Content/connect_resource_feeds_news.htm
      # @param opts [Hash] options for Salesforce
      def news_feed(user_id: :me, opts: {})
        get("/chatter/feeds/news/#{user_id}/feed-items", opts)
      end

      def user_profile_feed(user_id: :me, opts: {})
        get("/chatter/feeds/user-profile/#{user_id}/feed-items", opts)
      end

    end
  end
end
