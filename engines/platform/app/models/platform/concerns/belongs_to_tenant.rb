module Platform
  module Concerns
    module BelongsToTenant
      extend ActiveSupport::Concern

      included do
        belongs_to :platform_tenant, optional: true
        
        default_scope {
          Platform::Tenant.current ? where(platform_tenant_id: Platform::Tenant.current.id) : where(nil)
        }
      end
    end
  end
end