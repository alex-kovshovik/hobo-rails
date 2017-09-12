source 'https://rubygems.org'

gem 'rails', '~> 5.0.6'
gem 'puma'
gem 'jbuilder', '~> 2.5'
gem 'rack-cors'
gem 'pg'
gem 'active_model_serializers'

# Authentication and Facebook
gem 'simple_token_authentication'
gem 'koala'
gem 'pundit'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'rubocop'
  gem 'rails_best_practices'
  gem 'awesome_print'

  # Deployment
  gem 'capistrano', '~> 3.4'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
  gem 'capistrano-passenger'
  gem 'airbrussh', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
