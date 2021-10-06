module User
  module Helpers
    module AuthenticationHelper

      def auth_token_value_from_request
        params[:auth_token]
      end

      def current_account
        token = User::AuthenticationToken.find_by_token(auth_token_value_from_request)
        return nil unless token.present?
        @current_account ||= User::Account.find(token.user_account_id)
      end

      def signed_in?
        !!current_account
      end

      def authenticate!
        byebug
        unless signed_in?
          #AuditLog.create data: 'unauthenticated user access'
          error!({ :error_msg => "authentication_error", :error_code => Platform::ErrorCodes::BAD_AUTHENTICATION_PARAMS }, 401)
        end
      end

    end
  end
end