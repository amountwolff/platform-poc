require "grape"
require "grape/route_helpers"

module User
  class AuthAPI < Grape::API
    include Platform::Concerns::Errors
    
    version 'v1', using: :header, vendor: 'amount'
    format :json
    prefix :api

    resource :auth do
      desc 'Initiate login to a user account.', {
        success: Entities::AccountWithLoginToken,
        consumes: ['application/json', 'application/x-www-form-urlencoded']
      }
      params do
        requires :email, type: String, desc: 'email'
      end
      post :login do
        account = User::AccountLoginTokenGenerator.call(params[:email])

        #TODO: clean-up
        url = "http://" + request.headers["Host"] + api_auth_email_confirmation_path(params: { login_token: account.login_token })
        User::AccountMailer.validate_email(account, url).deliver_now

        status 200
        present account, with: Entities::AccountWithLoginToken
      end

      desc 'Authenticate the user via email confirmation.', {
        success: Entities::AccountWithAuthToken
      }
      params do
        requires :login_token, type: String, desc: 'the confirmable login token'
      end
      get :email_confirmation do
        account = User::AccountLoginTokenAuthenticator.call(params[:login_token])

        status 200
        present account, with: Entities::AccountWithAuthToken
      end
    end
  end
end