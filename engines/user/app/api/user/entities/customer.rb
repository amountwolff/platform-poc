module User
  module Entities
    class Customer < Grape::Entity
      expose :id
      expose :name
      expose :date_of_birth
      expose :ssn
    end
  end
end