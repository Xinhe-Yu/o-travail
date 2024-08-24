class UserProfilesController < ApplicationController
  def new
    @user_profile = UserProfile.new
  end

  def create
    @user_profile = UserProfile.new(profession: user_profile_params[:profession],
                                    terminology_preference: user_profile_params[:terminology_preference],
                                    experience: user_profile_params[:profession])
    @user_profile.birthday = user_profil_birthday_params
    if @user_profile.valid?
      current_user.update(user_profile_params)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_profile_params
    params.require(:user_profile)
          .permit(:profession, :terminology_preference, :experience, :'birthday(3i)', :'birthday(2i)', :'birthday(1i)')
  end

  def user_profil_birthday_params
    day = params[:user_profile]["birthday(3i)"].to_i
    month = params[:user_profile]["birthday(2i)"].to_i
    year = params[:user_profile]["birthday(1i)"].to_i
    Date.new(year, month, day)
  end
end
