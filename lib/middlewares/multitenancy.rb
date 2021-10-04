# frozen_string_literal: true
 
require "./app/proxies/database_proxy"
 
module Middlewares
  # selecting tenant based on subdomain
  class Multitenancy
    def initialize(app)
      @app = app
    end
 
    def call(env)
      Platform::Shard.reset_current
      Platform::Tenant.reset_current

      domain = ActionDispatch::Http::URL.extract_subdomain(env['HTTP_HOST'], 0)
 
      shard = Platform::Shard.find_by(domain: domain)
      return @app.call(env) unless shard
 
      shard.make_current
      Rails.logger.debug "Current shard set to: #{shard.shard}"

      DatabaseProxy.on_shard(shard: shard.shard.to_sym) do
        tenant = Platform::Tenant.find_by(subdomain: domain)
        Rails.logger.debug "Current tenant set to: #{tenant.id}"

        tenant&.make_current
        @app.call(env)
      end
    end
  end
end