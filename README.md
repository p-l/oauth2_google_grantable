# oauth2_google_grantable

Adds a grant_type "google" to the existing installation of
[devise_oauth2_providable](https://github.com/socialcast/devise_oauth2_providable)

## Features

* Allows to provide a `google_token` to authenticate
  against an OAuth2 API made with [devise_oauth2_providable](https://github.com/socialcast/devise_oauth2_providable)


## Requirements

* [Devise](https://github.com/plataformatec/devise) authentication library
* [Rails](http://rubyonrails.org/) 3.1 or higher
* [Devise OAuth2 Providable](https://github.com/socialcast/devise_oauth2_providable)

## Installation

#### Install gem
```ruby
# Gemfile
gem 'oauth2_google_grantable'
```

#### Configure User model to support Google authentication

Add `:oauth2_google_grantable` to your `devise` declaration as seen bellow.

```ruby
class User
  devise :oauth2_providable,
    :oauth2_password_grantable,
    :oauth2_refresh_token_grantable,
    :oauth2_google_grantable
end
```


## Using with Google grant_type on the client-side

To authentitcate against to the API using Google credentials you need to post
the API with the parameter `google_token` as shown bellow:

```ruby
post("/oauth/token",
  :format => :json,
  :google_token => TOKEN,
  :grant_type => "google",
  :client_secret => client_secret,
  :client_id => client_identifier)
```


## Contributing

* Fork the project
* Fix the issue
* Add unit tests
* Submit pull request on github



## License

Copyright (C) 2013 Pierre-Luc Simard
See LICENSE.txt for further details.

