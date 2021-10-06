require "grape"
require "grape/route_helpers"

module Onboarding
  class API < Grape::API
    include Platform::Concerns::Errors
    
    version 'v1', using: :header, vendor: 'amount'
    format :json
    prefix :api

    helpers User::Helpers::AuthenticationHelper
    helpers Platform::Helpers::AuthenticationHelper
    before { restrict_access_to_developers! }
    before { authenticate! }

    resource :onboarding do
      desc 'Get the onboarding session for the authenticated user.', {
        success: Entities::Session
      }
      get do
        session = Onboarding::Session.find_by(user_account_id: current_account.id)

        unless !!session
          error!({ :error_msg => "record_does_not_exist", :error_code => Platform::ErrorCodes::RECORD_DOESNT_EXIST }, 401)
        end

        status 200
        present session, with: Entities::Session
      end

      desc 'Create an onboarding session for the authenticated user.', {
        success: Entities::Session,
        consumes: ['application/json', 'application/x-www-form-urlencoded']
      }
      post do
        existing_session = Onboarding::Session.find_by(user_account_id: current_account.id)

        if !!existing_session
          error!({ :error_msg => "record_already_exists", :error_code => Platform::ErrorCodes::RECORD_ALREADY_EXISTS }, 401)
        end

        byebug

        new_session = Onboarding::Session.create!(status: Onboarding::SessionStatuses::IN_PROGRESS, expires_at: 5.days.from_now, user_account_id: current_account.id)

        status 200
        present new_session, with: Entities::Session
      end
    end
  end
end