require "grape"
require "grape/route_helpers"

module User
  class CustomerAPI < Grape::API
    include User::Concerns::Errors
    
    version 'v1', using: :header, vendor: 'amount'
    format :json
    prefix :api

    helpers User::Helpers::AuthenticationHelper
    helpers Platform::Helpers::AuthenticationHelper
    before { restrict_access_to_developers! }
    before { authenticate! }

    resource :customer do
      desc 'Get the authenticated user customer profile.', {
        success: Entities::AccountWithCustomer
      }
      get do
        status 200
        present current_account, with: Entities::AccountWithCustomer
      end

      desc 'Create a customer profile for the authenticated user.', {
        success: Entities::AccountWithCustomer,
        consumes: ['application/json', 'application/x-www-form-urlencoded']
      }
      params do
        requires :name, type: String, desc: 'customer full name'
        requires :date_of_birth, type: Date, desc: 'customer date of birth'
        requires :ssn, type: String, desc: 'customer social security number'
      end
      post do
        if !!current_account.customer
          error!({ :error_msg => "record_already_exists", :error_code => Platform::ErrorCodes::RECORD_ALREADY_EXISTS }, 401)
        end

        User::Customer.create!(name: params[:name], date_of_birth: params[:date_of_birth], ssn: params[:ssn], account: current_account)
        current_account.reload

        status 200
        present current_account, with: Entities::AccountWithCustomer
      end

      desc 'Update the customer profile for the authenticated user.', {
        success: Entities::AccountWithCustomer,
        consumes: ['application/json', 'application/x-www-form-urlencoded']
      }
      params do
        requires :name, type: String, desc: 'customer full name'
        requires :date_of_birth, type: Date, desc: 'customer date of birth'
        requires :ssn, type: String, desc: 'customer social security number'
      end
      put do
        unless !!current_account.customer
          error!({ :error_msg => "record_does_not_exist", :error_code => Platform::ErrorCodes::RECORD_DOESNT_EXISTS }, 401)
        end

        current_account.customer.update!(name: params[:name], date_of_birth: params[:date_of_birth], ssn: params[:ssn])
        current_account.reload

        status 200
        present current_account, with: Entities::AccountWithCustomer
      end
    end
  end
end