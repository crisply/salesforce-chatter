module Salesforce::Chatter

  module Authentication

    def authenticate_with_user!
      begin
        resp = oauth2_client.password.get_token username,"#{password}#{security_token}"
        self.token         = resp.token
        self.refresh_token = resp.refresh_token
        self.endpoint      = resp.params["instance_url"]
        true
      rescue OAuth2::Error => e
        raise AuthenticationError, "#{e.description}: #{e.code}"
      end
    end

    def refresh_token!
      begin
        resp = oauth2_access_token.refresh!
        self.token         = resp.token
        self.refresh_token = resp.refresh_token
        self.endpoint      = resp.params["instance_url"]
        true
      rescue OAuth2::Error => e
        raise AuthenticationError, "#{e.description}: #{e.code}"
      rescue RuntimeError => e
        if e.message =~ /A refresh_token is not available/
          raise AuthenticationError, e.message
        else
          raise
        end
      end
    end

    def authenticated?
      !(token.nil? || token.empty?)
    end


    private


    def oauth2_client
      @oauth2_client ||= OAuth2::Client.new(
        client_id, client_secret,
        site:          Configuration::DEFAULT_ENDPOINT,
        authorize_url: Configuration::AUTHORIZE_PATH,
        token_url:     Configuration::TOKEN_PATH)
    end

    def oauth2_access_token
      OAuth2::AccessToken.new(oauth2_client, token, refresh_token: refresh_token)
    end

  end

end
