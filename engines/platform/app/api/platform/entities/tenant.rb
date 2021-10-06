module Platform
  module Entities
    class Tenant < Grape::Entity
      expose :id, as: :tenant_id
      expose :name, as: :tenant_name
      expose :subdomain, as: :tenant_subdomain
    end
  end
end