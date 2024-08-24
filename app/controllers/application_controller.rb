class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_profile

  def configure_permitted_parameters
    keys = %i[username birthday terminology_preference profession experience 'birthday(3i)' 'birthday(2i)' 'birthday(1i)']
    devise_parameter_sanitizer.permit(:sign_up, keys:)
    devise_parameter_sanitizer.permit(:account_update, keys:)
  end

  private

  def check_profile
    return unless user_signed_in? && current_user.birthday.blank?
    return unless !request.path.starts_with?(new_user_profile_path) && !request.path.starts_with?(user_profiles_path)

    redirect_to new_user_profile_path
  end
end
