source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"

gem "propshaft"
gem "jsbundling-rails"
gem "cssbundling-rails"

# gem "solid_cache"
# gem "solid_queue"
# gem "solid_cable"

gem "bootsnap", require: false

gem "kamal", require: false
gem "thruster", require: false
gem "skylight"

gem "graphql", "~> 2.4.16" # skylight(6.0.4) graphql probe が 2.5.0 以降に対応していないため固定

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "graphiql-rails"
end
