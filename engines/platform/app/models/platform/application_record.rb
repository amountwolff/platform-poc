module Platform
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
   
    db_configs = Rails.application.config.database_configuration[Rails.env].keys
   
    db_configs = db_configs.each_with_object({}) do |key, configs|
      # key = default, db_key = default
      # key = default_replica, db_key = default
      db_key = key.gsub('_replica', '')
      role = key.eql?(db_key) ? :writing : :reading
   
      db_key = db_key.to_sym
      configs[db_key] ||= {}
   
      configs[db_key][role] = key.to_sym
    end
   
    # connects_to shards: {
    #   default: { writing: :default, reading: :default_replica },
    #   shard1: { writing: :shard1, reading: :shard1_replica }
    # }
    connects_to shards: db_configs
  end
end
