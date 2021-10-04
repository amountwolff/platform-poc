module Onboarding
  class Session < Platform::ApplicationRecord
    Platform::Concerns::BelongsToTenant

    belongs_to :user_account
  end
end