# frozen_string_literal: true
module Platform
  class Shard < GlobalRecord
    include Platform::Concerns::ActsAsCurrent
   
    before_create :set_current_shard
   
    private
   
    def set_current_shard
      self.shard = ENV["CURRENT_SHARD"]
    end
  end
end