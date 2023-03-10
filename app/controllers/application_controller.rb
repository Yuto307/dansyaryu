class ApplicationController < ActionController::Base
  include Pundit

  before_action :require_login
  before_action :set_current_user
  add_flash_types :success, :info, :warning, :danger

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    return unless @current_user.nil?

    redirect_to('/login')
  end

  private

  def not_authenticated
    flash[:warnimg] = t('defaults.message.require_login')
    redirect_to login_path
  end
end
