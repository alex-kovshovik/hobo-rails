set :application, 'hobo-rails-staging'
set :deploy_to, "/srv/www/#{fetch(:application)}"

server '192.241.209.22:3422', user: 'app', roles: %w(app db web)
