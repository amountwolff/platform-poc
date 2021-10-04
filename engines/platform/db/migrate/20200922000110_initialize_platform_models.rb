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
  end
end
