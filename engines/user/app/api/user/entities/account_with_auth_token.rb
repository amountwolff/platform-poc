module User
  module Entities
    class AccountWithAuthToken < User::Entities::Account
      expose :auth_token do |account, options|
        account.authentication_tokens.valid.first.token
      end
    end
  end
end