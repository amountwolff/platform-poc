require 'grape-swagger'

module Root
  class API < Grape::API
    format :json
    mount User::API
    add_swagger_documentation
  end
end