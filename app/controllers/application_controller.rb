class ApplicationController < ActionController::Base
  include Pundit

  acts_as_token_authentication_handler_for User
  before_action :authenticate_user!, :setup_stamps

  private

  def setup_stamps
    System.current_user = current_user
    System.current_process = "#{self.class}/#{action_name}"
  end
end
