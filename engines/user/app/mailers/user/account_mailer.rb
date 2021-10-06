module User
  class AccountMailer < ApplicationMailer
    def validate_email(account, url)
      @account = account
      @url  = url
      mail to: @account.email, subject: 'Sign-in to Amount.com'
    end
  end
end