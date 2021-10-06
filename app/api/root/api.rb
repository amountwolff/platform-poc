require 'grape-swagger'

module Root
  class API < Grape::API
    format :json
    mount Platform::API
    mount User::AuthAPI
    mount User::CustomerAPI
    mount Onboarding::API
    add_swagger_documentation :info => {:title => 'Amount Platform PoC'}
  end
end