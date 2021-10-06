#TODO: DELETE

require_relative('../strategies/passwordless_authenticatable')

module Devise
  module Models
    module PasswordlessAuthenticatable
      extend ActiveSupport::Concern
    end
  end
end