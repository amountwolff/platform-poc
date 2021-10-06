module Onboarding
  module Entities
    class Session < Grape::Entity
      expose :id, as: :onboarding_session_id
      expose :status
      expose :expires_at
    end
  end
end