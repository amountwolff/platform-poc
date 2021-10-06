module Platform
  module Concerns
    module Errors
      extend ActiveSupport::Concern

      included do
        rescue_from :all do |e|
          error!(message: e.message, status: 500)
        end
      end
    end
  end
end