class InitializeDatabase < ActiveRecord::Migration[6.1]
  def change
      #replaced by engine migrations

      # create_table "platform_shards", force: :cascade do |t|
      #   t.string "domain"
      #   t.string "shard"
      #   t.datetime "created_at", precision: 6, null: false
      #   t.datetime "updated_at", precision: 6, null: false
      #   t.integer "tenant_id"
      # end

      # create_table "platform_tenants", force: :cascade do |t|
      #   t.string "name"
      #   t.string "subdomain"
      #   t.datetime "created_at", precision: 6, null: false
      #   t.datetime "updated_at", precision: 6, null: false
      # end

      # create_table "user_customers", force: :cascade do |t|
      #   t.string "name"
      #   t.date "date_of_birth"
      #   t.string "ssn"
      #   t.datetime "created_at", precision: 6, null: false
      #   t.datetime "updated_at", precision: 6, null: false
      #   t.bigint "platform_tenant_id"
      #   t.bigint "user_account_id"
      #   t.index ["platform_tenant_id"], name: "index_user_customers_on_platform_tenant_id"
      #   t.index ["user_account_id"], name: "index_user_customers_on_user_account_id"
      # end

      # create_table "user_accounts", force: :cascade do |t|
      #   t.string "email", default: "", null: false
      #   t.string "encrypted_password", default: "", null: false
      #   t.string "reset_password_token"
      #   t.datetime "reset_password_sent_at"
      #   t.datetime "remember_created_at"
      #   t.datetime "created_at", precision: 6, null: false
      #   t.datetime "updated_at", precision: 6, null: false
      #   t.bigint "platform_tenant_id"
      #   t.index ["email"], name: "index_user_accounts_on_email", unique: true
      #   t.index ["reset_password_token"], name: "index_user_accounts_on_reset_password_token", unique: true
      #   t.index ["platform_tenant_id"], name: "index_user_accounts_on_platform_tenant_id"
      # end

      # add_foreign_key "user_accounts", "platform_tenants"
      # add_foreign_key "user_customers", "platform_tenants"
      # add_foreign_key "user_customers", "user_accounts"
  end
end