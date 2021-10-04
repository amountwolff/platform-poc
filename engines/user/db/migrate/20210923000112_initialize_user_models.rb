class InitializeUserModels < ActiveRecord::Migration[6.1]
  def change
      create_table "user_customers", force: :cascade do |t|
        t.string "name"
        t.date "date_of_birth"
        t.string "ssn"
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
        t.bigint "platform_tenant_id"
        t.bigint "user_account_id"
        t.index ["platform_tenant_id"], name: "index_user_customers_on_platform_tenant_id"
        t.index ["user_account_id"], name: "index_user_customers_on_user_account_id"
      end

      create_table "user_accounts", force: :cascade do |t|
        t.string "email", default: "", null: false
        t.string "encrypted_password", default: "", null: false
        t.string "reset_password_token"
        t.datetime "reset_password_sent_at"
        t.datetime "remember_created_at"
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
        t.bigint "platform_tenant_id"

        ## Trackable
        t.integer  :sign_in_count, default: 0, null: false
        t.datetime :current_sign_in_at
        t.datetime :last_sign_in_at
        t.string   :current_sign_in_ip
        t.string   :last_sign_in_ip

        ## Confirmable
        t.string   :confirmation_token
        t.datetime :confirmed_at
        t.datetime :confirmation_sent_at
        # t.string   :unconfirmed_email # Only if using reconfirmable

        ## Lockable
        # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
        # t.string   :unlock_token # Only if unlock strategy is :email or :both
        # t.datetime :locked_at

        ## Passwordless
        t.string   :login_token
        t.datetime :login_token_valid_until

        t.index ["email"], name: "index_user_accounts_on_email", unique: true
        t.index ["reset_password_token"], name: "index_user_accounts_on_reset_password_token", unique: true
        t.index ["platform_tenant_id"], name: "index_user_accounts_on_platform_tenant_id"
        t.index ["confirmation_token"], name: "index_user_accounts_on_confirmation_token", unique: true
        t.index ["login_token"], name: "index_user_accounts_on_login_token", unique: true
        # t.index ["unlock_token"], name: "index_user_accounts_on_unlock_token", unique: true
      end

      add_foreign_key "user_accounts", "platform_tenants"
      add_foreign_key "user_customers", "platform_tenants"
      add_foreign_key "user_customers", "user_accounts"
  end
end
