require_relative "lib/platform/version"

Gem::Specification.new do |spec|
  spec.name        = "platform"
  spec.version     = Platform::VERSION
  spec.authors     = ["Nick Wolff"]
  spec.email       = ["nicolas.wolff@amount.com"]
  spec.summary     = "Platform Utlities"
  spec.description = "Platform Utlities"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "Rakefile"]

  spec.add_dependency "rails", "~> 6.1.4", ">= 6.1.4.1"
  spec.add_dependency "pg", "~> 1.2.3"
  spec.add_dependency "bcrypt", "3.1.13"

  spec.add_development_dependency "pg"
end
