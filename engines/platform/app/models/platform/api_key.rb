# frozen_string_literal: true
module Platform
  class APIKey < ApplicationRecord
    include Platform::Concerns::BelongsToTenant

    validates :token, presence: true
    scope :valid,  -> { where("expires_at > ?", Time.zone.now) }

    def self.generate!(target_tenant_id)
      platform_tenant_id = target_tenant_id || Platform::Tenant.current

      raise "no current tenant set" unless platform_tenant_id

      token = SecureRandom.hex(10)
      exp = 365.days.from_now
      
      apiKey = self.new(token: token, expires_at: exp, platform_tenant_id: platform_tenant_id)
      apiKey.save!

      return apiKey
    end
  end
end