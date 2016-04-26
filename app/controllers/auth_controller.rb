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

    render json: { email: user.email, token: user.authentication_token }, status: :ok
  end

  # Accepts "email" and "token".
  # Renders nothing:
  #  - with HTTP OK (200) if correct
  #  - with HTTP UNAUTHORIZED (401) if incorrect
  def check
    user = User.find_by(email: params[:email], authentication_token: params[:token])

    head user.present? ? :ok : :unauthorized
  rescue
    head :unauthorized
  end

  private

  def validate_facebook_token
    graph = Koala::Facebook::API.new(params[:facebookAccessToken])
    profile = graph.get_object('me?fields=name,email') # This makes a simple facebook call to make sure we have access
    raise :unauthorized if params[:email] != profile['email']
  rescue Koala::Facebook::AuthenticationError
    head :unauthorized
  rescue StandardError
    head :unprocessable_entity
  end
end
