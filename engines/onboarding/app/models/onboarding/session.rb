module Onboarding
  class Session < Platform::ApplicationRecord
    include Platform::Concerns::BelongsToTenant

    belongs_to :user_account, optional: true, foreign_key: "user_account_id"
  end
end