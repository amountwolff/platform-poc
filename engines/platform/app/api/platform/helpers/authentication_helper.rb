module Platform
  module Helpers
    module AuthenticationHelper

      def current_tenant
        Platform::Tenant.current
      end

      def restrict_access_to_developers!
        header_token = headers['Authorization']
        key = Platform::APIKey.find_by(token: header_token)
        Rails.logger.info "API call: #{headers}\tWith params: #{params.inspect}" if ENV['DEBUG']
        if key.blank?
          error_code = Platform::ErrorCodes::DEVELOPER_KEY_MISSING
          error_msg = 'please aquire a developer key'
          error!({ :error_msg => error_msg, :error_code => error_code }, 401)
          # LogAudit.new({env:env}).execute
        end

        if key.platform_tenant_id != current_tenant.id
          error_code = Platform::ErrorCodes::BAD_AUTHENTICATION_PARAMS
          error_msg = 'developer key not associated with target tenant'
          error!({ :error_msg => error_msg, :error_code => error_code }, 401)
        end
      end
    end
  end
end