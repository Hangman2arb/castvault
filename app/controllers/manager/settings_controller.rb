class Manager::SettingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @title = 'Ajustes'
    @description = 'Modifica tus ajustes para toda la plataforma'
  end

  def update
    if current_user.update(user_params)
      redirect_to manager_settings_path, notice: 'Settings were successfully updated.'
    else
      redirect_to manager_settings_path, alert: 'Unable to update settings.'
    end
  end

  def password_change
    if password_change_params[:password].blank? || password_change_params[:password_confirmation].blank?
      current_user.errors.add(:password, :blank, message: "cannot be blank") if password_change_params[:password].blank?
      current_user.errors.add(:password_confirmation, :blank, message: "cannot be blank") if password_change_params[:password_confirmation].blank?
      render :index, alert: 'Password and password confirmation cannot be blank.'
    elsif current_user.update_with_password(password_change_params)
      redirect_to manager_settings_path, notice: 'Password was successfully updated.'
    else
      render :index, alert: 'There was a problem updating your password.'
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :language, :time_zone, :profile_photo)
  end

  def password_change_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
