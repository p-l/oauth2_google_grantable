
module Devise
  module Strategies
    class Oauth2GoogleGrantTypeStrategy < Oauth2GrantTypeStrategy
      def grant_type
        Devise::Oauth2ProvidableGoogle.logger.debug("Google Grant Loaded")
        'google'
      end

      def authenticate_grant_type(client)
        Devise::Oauth2ProvidableGoogle.logger.debug("Oauth2GoogleGrantTypeStrategy => Getting user information for token:\"#{params[:google_token]}\"")
        google_user = Devise::Oauth2ProvidableGoogle.google_userinfo_for_token(params[:google_token])

        if(google_user && google_user["email"] && google_user["verified_email"])
          Devise::Oauth2ProvidableGoogle.logger.debug("Oauth2GoogleGrantTypeStrategy => Searching for user with email:\"#{google_user[:email]}\"")
          resource = mapping.to.find_for_authentication(:email => google_user["email"].to_s)
          if(!resource)
            # Create resource if none exist.
            # TODO: Set this as an option
            Devise::Oauth2ProvidableGoogle.logger.debug("Oauth2GoogleGrantTypeStrategy => Could not find user\"#{google_user["email"]}\"")
            resource = mapping.to.create(:email => google_user["email"].to_s, :name => google_user["name"].to_s, :password => SecureRandom.hex())
          end
        else
          Devise::Oauth2ProvidableGoogle.logger.debug("Oauth2GoogleGrantTypeStrategy => Token is not valid")
          oauth_error! :invalid_grant, 'could not authenticate to Google'
        end

        # Response
        if(resource)
          Devise::Oauth2ProvidableGoogle.logger.debug("Oauth2GoogleGrantTypeStrategy => Token is valid")
          success!(resource)
        else
          Devise::Oauth2ProvidableGoogle.logger.debug("Oauth2GoogleGrantTypeStrategy => User not found and could not be created")
          oauth_error! :invalid_grant, 'could not authenticate'
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_google_grantable, Devise::Strategies::Oauth2GoogleGrantTypeStrategy)
