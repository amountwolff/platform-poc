# frozen_string_literal: true
module Platform
  class GlobalRecord < ActiveRecord::Base
    self.abstract_class = true
   
    connects_to database: { writing: :default, reading: :default_replica }
  end
end