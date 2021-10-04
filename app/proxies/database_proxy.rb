# frozen_string_literal: true
class DatabaseProxy
  class << self
    def on_shard(shard: , &block)
      _connect_to_(role: :writing, shard: shard, &block)
    end
 
    def on_replica(shard: , &block)
      _connect_to_(role: :reading, shard: shard, &block)
    end
 
    def on_global_replica(&block)
      _connect_to_(klass: GlobalRecord, role: :reading, &block)
    end
 
    # for regular executions, since Global only connects to default shard,
    # no explicit connection switching is required.
    # def on_global(&block)
    #   _connect_to_(klass: GlobalRecord, role: :writing, &block)
    # end
 
    private
 
    def _connect_to_(klass: Platform::ApplicationRecord, role: :writing, shard: :default, &block)
      klass.connected_to(role: role, shard: shard) do
        block.call
      end
    end
  end
end