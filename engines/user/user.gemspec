require_relative "lib/user/version"

Gem::Specification.new do |spec|
  spec.name        = "user"
  spec.version     = User::VERSION
  spec.authors     = ["Nick Wolff"]
  spec.email       = ["nicolas.wolff@amount.com"]
  spec.summary     = "User Authentication"
  spec.description = "User Authentication"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "Rakefile"]

  spec.add_dependency "rails", "~> 6.1.4", ">= 6.1.4.1"
  spec.add_dependency "devise", "~> 4.7.1"
  spec.add_dependency "pg", "~> 1.2.3"
  spec.add_dependency "bcrypt", "3.1.13"

  spec.add_development_dependency "pg"
end
