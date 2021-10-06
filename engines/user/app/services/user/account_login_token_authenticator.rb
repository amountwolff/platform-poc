module User
  class AccountLoginTokenAuthenticator < ApplicationService
    attr_reader :login_token
  
    def initialize(login_token)
      @login_token = login_token
    end

    def call
        user_account = User::Account.find_by(login_token: @login_token)
        user_account.update(login_token: nil, login_token_valid_until: 1.year.ago)
        user_account.confirm
        auth_token = user_account.authentication_tokens.valid.first || User::AuthenticationToken.generate!(user_account)

        return auth_token.account
    end
  end
end