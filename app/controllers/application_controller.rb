class ApplicationController < ActionController::Base
  include Pundit

  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!
end
