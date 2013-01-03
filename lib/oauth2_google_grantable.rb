require 'devise'
require 'rack/oauth2'
require 'devise_oauth2_providable'
require 'net/https'
require 'json'
require 'securerandom'

require 'devise/oauth2_google_grantable/models/oauth2_google_grantable'
require 'devise/oauth2_google_grantable/strategies/google_grant_type'

module Devise
  module Oauth2ProvidableGoogle
    def self.logger
      @@logger
    end
    def self.logger=(logger)
      @@logger = logger
    end
    def self.debugging?
      @@debugging
    end
    def self.debugging=(boolean)
      @@debugging = boolean
    end

    def self.google_userinfo_for_token(token)
      begin
        @@logger.error("Oauth2ProvidableGoogle => Getting information from user token: #{token}")
        # Documentation on the API Call: https://developers.google.com/accounts/docs/OAuth2Login#userinfocall
        uri = URI.parse("https://www.googleapis.com/oauth2/v1/userinfo?access_token=#{token}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        # Don't verify SSL
        #http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(uri.request_uri)

        response = http.request(request)
        if(response.status == 200)
          data = response.body
          json = JSON.parse(data)
          return json
        end
      rescue => e
        @@logger.error("Oauth2ProvidableGoogle => Could not authenticate with token: #{e}")
        return false
      end

    end

    class Railties < ::Rails::Railtie
      initializer 'Rails logger' do
        Devise::Oauth2ProvidableGoogle.logger = Rails.logger
      end
    end

    class Engine < Rails::Engine
      engine_name 'oauth2_google_grantable'
      isolate_namespace Devise::Oauth2ProvidableGoogle
      initializer "oauth2_google_grantable.initialize_application", :before=> :load_config_initializers do |app|
        app.config.filter_parameters << :google_token
      end
    end

  end
end

Devise.add_module(:oauth2_google_grantable,
                  :strategy => true,
                  :model => "devise/oauth2_google_grantable/models/oauth2_google_grantable")
