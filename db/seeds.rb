require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Platform::ApplicationRecord.connected_to(role: :writing, shard: :shard1) do
	@tenant1 = Platform::Tenant.create!(name: Faker::Company.name, subdomain: Faker::Internet.domain_word)
	@account1 = User::Account.create!(email: Faker::Internet.safe_email, password: Faker::Internet.password, platform_tenant_id: @tenant1.id)
	@customer1 = User::Customer.create!(name: Faker::Name.name, date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65), ssn: Faker::IDNumber.valid, platform_tenant_id: @tenant1.id, user_account_id: @account1.id)

	@tenant2 = Platform::Tenant.create!(name: Faker::Company.name, subdomain: Faker::Internet.domain_word)
	@account2 = User::Account.create!(email: Faker::Internet.safe_email, password: Faker::Internet.password, platform_tenant_id: @tenant2.id)
	@customer2 = User::Customer.create!(name: Faker::Name.name, date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65), ssn: Faker::IDNumber.valid, platform_tenant_id: @tenant2.id, user_account_id: @account2.id)
end
