module User
  module Concerns
    module Errors
      extend ActiveSupport::Concern

      included do
        rescue_from :all do |e|
          rack_response API::Utils::ApiErrors.new({type: e.class.name, message: e.message}).to_json, 500
        end
      end
    end
  end
end