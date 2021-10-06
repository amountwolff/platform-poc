require "grape/route_helpers"

module User
  class AccountLoginTokenGenerator < ApplicationService
    attr_reader :email
  
    def initialize(email)
      @email = email
    end

    def call
        account = User::Account.find_or_create_by(email: @email) do |inst|
          inst.skip_confirmation_notification!
        end

        account.login_token = SecureRandom.hex(10)
        account.login_token_valid_until = Time.now + 60.minutes
        account.save!

        return account
    end
  end
end