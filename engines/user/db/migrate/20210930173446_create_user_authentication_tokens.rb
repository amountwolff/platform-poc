class CreateUserAuthenticationTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :user_authentication_tokens do |t|
      t.string :token
      t.references :platform_tenant, null: false, foreign_key: true
      t.references :user_account, null: false, foreign_key: true
      t.datetime :expires_at

      t.timestamps
    end
  end
end
