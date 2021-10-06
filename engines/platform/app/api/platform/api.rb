require "grape"
require "grape/route_helpers"

module Platform
  class API < Grape::API
    include Platform::Concerns::Errors

    helpers Platform::Helpers::AuthenticationHelper
    before { restrict_access_to_developers }
    
    version 'v1', using: :header, vendor: 'amount'
    format :json
    prefix :api

    resource :platform do
      desc 'Get status information about the platform.', {
        success: Platform::Entities::Tenant
      }
      get do
        status 200
        present Platform::Tenant.current, with: Platform::Entities::Tenant
      end
    end
  end
end