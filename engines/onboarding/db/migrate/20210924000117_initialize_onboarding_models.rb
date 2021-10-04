class InitializeOnboardingModels < ActiveRecord::Migration[6.1]
  def change
    create_table :onboarding_sessions do |t|
      t.string :status
      t.datetime :expires_at
      t.references :platform_tenant, null: false, foreign_key: true
      t.references :user_account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
