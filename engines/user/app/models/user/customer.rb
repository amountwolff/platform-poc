module User
  class Customer < Platform::ApplicationRecord
    include Platform::Concerns::BelongsToTenant

    belongs_to :user_account, optional: true

    #disable
    def send_on_create_confirmation_instructions
      #
    end
  end
end
