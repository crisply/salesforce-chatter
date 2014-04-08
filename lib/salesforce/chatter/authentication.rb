module Salesforce::Chatter

  module Authentication

    def authenticate(options={})
      options[:client_id]     = Salesforce::Chatter.consumer_key
      options[:client_secret] = Salesforce::Chatter.consumer_secret
      options[:username]      = Salesforce::Chatter.username
      options[:password]      = Salesforce::Chatter.password + Salesforce::Chatter.security_token
      options[:grant_type]    = 'password'

      response = post('services/oauth2/token', options)
      Salesforce::Chatter.oauth_token = response.access_token
      response
    end

    def authentication
      {
        consumer_key:     consumer_key,
        consumer_secret:  consumer_secret,
        token:            oauth_token,
        refresh_token:    oauth_refresh_token
      }
    end

    def authenticated?
      !oauth_token.nil?
    end

  end

end
