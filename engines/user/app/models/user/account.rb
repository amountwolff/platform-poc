module User
  class Account < Platform::ApplicationRecord
    include Platform::Concerns::BelongsToTenant

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :confirmable, :passwordless_authenticatable,
           :trackable

    has_one :user_customer
    has_many :authentication_tokens

    def password_required?
     false
    end
  end
end
