# Facilitates authentication.
class AuthController < ApplicationController
  skip_before_action :authenticate_user!
  acts_as_token_authentication_handler_for User, except: [:register, :check]

  # Accepts Facebook short lived token, user email and name.
  # Renders application-specific access token.
  def register
    user = User.find_or_initialize_by(email: params[:email])
    user.password = Devise.friendly_token.first(8)
    user.password_confirmation = user.password

    if user.new_record?
      user.save!
    else
      # TODO: make Facebook API call to validate authentication and retgrieve long term token.
    end

    if user
      render json: { email: user.email, token: user.authentication_token }, status: :ok
    else
      head :unprocessable_entity
    end
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
end
