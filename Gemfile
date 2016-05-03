source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Authentication and Facebook
gem 'devise'
gem 'simple_token_authentication'
gem 'koala'
gem 'pundit'

# API
gem 'active_model_serializers'
gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'

  # Deployment
  gem "capistrano", "~> 3.4"
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
  gem 'capistrano-passenger'
  gem 'airbrussh', require: false
end

group :test do
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'awesome_print'
  gem 'rails_best_practices'
  gem 'rubocop'
end
