# frozen_string_literal: true

module User
  class SessionsController < Devise::SessionsController

    def create
      build_account_on_email

      warden.authenticate(:scope => resource_name)
      
      result = warden.result

      @account.reload

      if result == :custom
        message = warden.custom_response

        render :status => 200,
               :json => { :success => true,
                          :info => "pending email confirmation",
                          :data => {:message => message, :errors => [], :account => @account} }
      elsif result == :failure
        message = warden.message
        errors = warden.errors

        render :status => 401,
               :json => { :success => true,
                          :info => "login failed",
                          :data => {:message => message, :errors => errors, :account => @account} }
      else
        raise "unexpected result from authentication strategy evaluation"   
      end
    end

    def email_confirmation
      find_account_from_login_token
    
      account_exists = @account.present?
      account_confirmed = confirm_account(@account) if account_exists
      account_token = User::AuthenticationToken.generate!(@account)

      if (account_exists && account_confirmed && !!account_token)
        render :status => 200, :json => { :success => true, :info => "login successful", :data => {:token => account_token} }
      else
        render :status => 401, :json => { :success => true, :info => "login failed" }
      end
    end

    private

    def find_account_from_login_token
      @account = User::Account.find_by(login_token: params[:login_token])
    end

    def confirm_account(account)
       account.update(login_token: nil, login_token_valid_until: 1.year.ago)
       account.confirm
       sign_in(account)
    end

    def build_account_on_email
      @account = User::Account.find_or_create_by(email: params[:account][:email]) do |account|
        account.skip_confirmation_notification!
      end
    end
  end
end