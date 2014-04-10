Salesforce Chatter Ruby Gem
===========================
A Ruby wrapper for the Salesforce Chatter REST API

Usage
=====

## Instantiating a Client

### With OAuth Tokens

```ruby
client = Salesforce::Chatter.new(
  endpoint: <instance_url>,
  token:    <oauth_token>,
  refresh_token: <oauth_refresh_token>,
  client_id: <client_id>,
  client_secret: <client_secret>,
)
# If you need to refresh your token...
client.refresh_token!
```

### With a password grant

```ruby
client = Salesforce::Chatter.new(
  username: <username>,
  password: <password>,
  security_token: <security_token>,
  client_id: <client_id>,
  client_secret: <client_secret>,
)
client.authenticate_with_user!
```

## FeedItems

```ruby
# Get your FeedItems
items = client.feed_items
```


Contributing to salesforce-chatter
==================================
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Acknowledgements
================
The design for this project was based on the [Twitter](https://github.com/jnunemaker/twitter) gem.

Copyright
=========
Copyright (c) 2011 Dylan Vaughn. See LICENSE.txt for further details.

Copyright (c) 2014 Dan Wanek. See LICENSE.txt for further details.
