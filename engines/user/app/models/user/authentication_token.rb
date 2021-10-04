require 'user/json_web_token'

module User
  class AuthenticationToken < Platform::ApplicationRecord
    include Platform::Concerns::BelongsToTenant

    belongs_to :user_account, optional: true
    validates :token, presence: true
    scope :valid,  -> { where{ (expires_at == nil) | (expires_at > Time.zone.now) } }

    def self.generate!(account)
      return unless account

      payload = {account_id: account.id}
      exp = 2.hours.from_now
      jwt_token = JsonWebToken.encode(payload, exp)
      
      account_auth_token = self.new(token: jwt_token, user_account_id: account.id, expires_at: exp)
      account_auth_token.save!

      return account_auth_token
    end
  end
end
