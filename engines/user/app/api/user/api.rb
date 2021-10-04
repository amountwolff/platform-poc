require "grape"
require "grape/route_helpers"

module User
  class API < Grape::API
    version 'v1', using: :header, vendor: 'amount'
    format :json
    prefix :api

    helpers do
      TOKEN_PARAM_NAME = :token

      def token_value_from_request(token_param = TOKEN_PARAM_NAME)
        params[token_param]
      end

      def current_account
        token = User::AuthenticationToken.find_by_token(token_value_from_request)
        return nil unless token.present?
        @current_account ||= User::Account.find(token.user_account_id)
      end

      def signed_in?
        !!current_account
      end

      def authenticate!
        unless signed_in?
          #AuditLog.create data: 'unauthenticated user access'
          error!({ :error_msg => "authentication_error", :error_code => User::ErrorCodes::BAD_AUTHENTICATION_PARAMS }, 401)
        end
      end
    end

    resource :accounts do
      desc 'Initiate login to a user account.'
      params do
        requires :email, type: String, desc: 'email'
      end
      post :login do
        account = User::Account.find_or_create_by(email: params[:email]) do |inst|
          inst.skip_confirmation_notification!
          inst.login_token = SecureRandom.hex(10)
          inst.login_token_valid_until = Time.now + 60.minutes
        end

        #TODO: fix
        url = "http://" + request.headers["Host"] + api_accounts_email_confirmation_path(params: { login_token: account.login_token })

        User::AccountMailer.validate_email(account, url).deliver_now

        return {success: true, message: "email confirmation sent"}
      end

      desc 'Complete login to a user account through email confirmation.'
      params do
        requires :login_token, type: String, desc: 'login token'
      end
      get :email_confirmation do
        login_account = User::Account.find_by(login_token: params[:login_token])
        login_account.update(login_token: nil, login_token_valid_until: 1.year.ago)
        login_account.confirm
        auth_token = User::AuthenticationToken.generate!(login_account)

        return {success: true, message: "authenticated", token: auth_token.token}
      end


      desc 'Return all accounts for the current tenant.'
      get :all do
        User::Account.all
      end

      desc 'Return the current user account.'
      get :profile do
        authenticate!
        current_account
      end
    end
  end
end