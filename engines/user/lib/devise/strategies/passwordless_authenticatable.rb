require 'devise/strategies/authenticatable'
require_relative '../../../app/mailers/user/account_mailer'
module Devise
  module Strategies
    class PasswordlessAuthenticatable < Authenticatable
      include Rails.application.routes.url_helpers
      include User::Engine.routes.url_helpers

      def authenticate!
        byebug
        if params[:email].present?
          resource = User::Account.find_by(email: params[:email])

          if resource&.update(login_token: SecureRandom.hex(10),
                          login_token_valid_until: Time.now + 60.minutes)
            
            url = User::Engine.routes.url_helpers.email_confirmation_url(
              host: Rails.application.routes.default_url_options[:host],
              subdomain: Platform::Tenant.current.subdomain,
              login_token: resource.login_token
            )

            User::AccountMailer.validate_email(resource, url).deliver_now

            custom!("An email was sent to you with a magic link.")
          end

        end
      end
    end
  end
end

Warden::Strategies.add(:passwordless_authenticatable, Devise::Strategies::PasswordlessAuthenticatable)