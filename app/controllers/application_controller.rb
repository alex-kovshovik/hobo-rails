class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate, :set_audit_info

  attr_reader :current_user

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      email = options['email']
      next nil if email.blank?

      user = User.find_by(email: email)
      next nil if user.blank?

      if ActiveSupport::SecurityUtils.secure_compare(user.api_key, token)
        @current_user = user
      end
    end
  end

  def set_audit_info
    Thread.current.thread_variable_set(:current_user_id, current_user&.id)
    Thread.current.thread_variable_set(:changed_by, "#{self.class}/#{action_name}")
  end

  def render_unauthorized(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render json: { error: 'Bad credentials' }, status: :unauthorized
  end
end
