module User
  class Account < Platform::ApplicationRecord
    include Platform::Concerns::BelongsToTenant

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :confirmable, :passwordless_authenticatable,
           :trackable

    has_one :customer, foreign_key: "user_account_id"
    has_many :authentication_tokens, foreign_key: "user_account_id"

    def password_required?
     false
    end
  end
end
