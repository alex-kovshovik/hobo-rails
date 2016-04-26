class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!

  def render_data(data)
    if data
      render json: data
    else
      head :not_found
    end
  end

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
