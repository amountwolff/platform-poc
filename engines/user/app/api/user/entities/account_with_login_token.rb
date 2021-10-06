module User
  module Entities
    class AccountWithLoginToken < User::Entities::Account
      expose :login_token
      expose :login_token_valid_until
    end
  end
end