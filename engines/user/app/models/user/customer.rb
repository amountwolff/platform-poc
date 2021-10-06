module User
  class Customer < Platform::ApplicationRecord
    include Platform::Concerns::BelongsToTenant

    belongs_to :account, optional: true, foreign_key: "user_account_id"

    #disable
    def send_on_create_confirmation_instructions
      #
    end
  end
end
