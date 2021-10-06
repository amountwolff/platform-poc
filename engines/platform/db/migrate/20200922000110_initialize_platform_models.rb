class InitializePlatformModels < ActiveRecord::Migration[6.1]
  def change
      create_table "platform_shards", force: :cascade do |t|
        t.string "domain"
        t.string "shard"
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
        t.integer "tenant_id"
      end

      create_table "platform_tenants", force: :cascade do |t|
        t.string "name"
        t.string "subdomain"
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
      end

      create_table "platform_api_keys", force: :cascade do |t|
        t.string "token"
        t.datetime "expires_at"
        t.bigint "platform_tenant_id", null: false
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
        t.index ["platform_tenant_id"], name: "index_platform_api_keys_on_platform_tenant_id"
      end

      add_foreign_key "platform_api_keys", "platform_tenants"
  end
end
