# Facilitates authentication.
class AuthController < ApplicationController
  skip_before_action :authenticate_user!
  acts_as_token_authentication_handler_for User, except: [:register, :check]

  before_action :validate_facebook_token, only: :register

  # Accepts Facebook short lived token, user email and name.
  # Renders application-specific access token.
  def register
    user = User.find_or_initialize_by(email: params[:email])

    if user.new_record?
      user.password = Devise.friendly_token.first(10)
      user.password_confirmation = user.password
      user.save!
    end

    update_user_profile(user, @profile)

    render json: user, status: :ok
  end

  # Accepts "email" and "token".
  # Renders nothing:
  #  - with HTTP OK (200) if correct
  #  - with HTTP UNAUTHORIZED (401) if incorrect
  def check
    user = User.find_by!(email: params[:email], authentication_token: params[:token])

    render json: user, status: :ok
  rescue
    head :unauthorized
  end

  private

  def validate_facebook_token
    graph = Koala::Facebook::API.new(params[:facebookAccessToken])

    # This makes a simple Facebook call to make sure we have access
    @profile = graph.get_object('me?fields=first_name,last_name,email,currency,timezone')
    raise :unauthorized if params[:email] != @profile['email']
  rescue Koala::Facebook::AuthenticationError
    head :unauthorized
  rescue StandardError
    head :unprocessable_entity
  end

  def update_user_profile(user, profile)
    user.first_name = profile['first_name']
    user.last_name = profile['last_name']
    user.save!

    family = user.family
    family.currency = profile['currency']['user_currency']
    family.timezone = profile['timezone']
    family.save!
  end

end
