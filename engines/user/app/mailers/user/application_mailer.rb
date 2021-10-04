module User
  class ApplicationMailer < ActionMailer::Base
    default from: 'no-reply@amount.com'
    layout 'mailer'
  end
end
