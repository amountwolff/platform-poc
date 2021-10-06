module User
  module Entities
    class Account < Grape::Entity
      expose :id, as: :user_id
      expose :email
    end
  end
end