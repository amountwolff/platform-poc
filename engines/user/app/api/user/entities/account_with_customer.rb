module User
  module Entities
    class AccountWithCustomer < User::Entities::Account
      expose :customer, documentation: { type: User::Entities::Customer } do |account, options|
        User::Entities::Customer.represent account.customer
      end
    end
  end
end