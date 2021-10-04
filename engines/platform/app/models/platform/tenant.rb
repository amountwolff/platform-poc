# frozen_string_literal: true
module Platform
  class Tenant < ApplicationRecord
    include Platform::Concerns::ActsAsCurrent
    
    after_commit :set_shard, on: :create
   
    private
   
    def set_shard
      Shard.create!(tenant_id: self.id, domain: subdomain)
    end
  end
end