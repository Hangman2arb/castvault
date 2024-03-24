class Manager::SettingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @title = t('settings_controller.title')
    @description = t('settings_controller.description')
  end

  def update
    if current_user.update(user_params)
      redirect_to manager_settings_path, notice: t('settings_controller.settings_updated')
    else
      redirect_to manager_settings_path, alert: t('settings_controller.unable_to_update_settings')
    end
  end

  def password_change
    if password_change_params[:password].blank? || password_change_params[:password_confirmation].blank?
      current_user.errors.add(:password, :blank, message: t('errors.messages.blank')) if password_change_params[:password].blank?
      current_user.errors.add(:password_confirmation, :blank, message: t('errors.messages.blank')) if password_change_params[:password_confirmation].blank?
      render :index, alert: t('settings_controller.password_blank')
    elsif current_user.update_with_password(password_change_params)
      redirect_to manager_settings_path, notice: t('settings_controller.password_updated')
    else
      render :index, alert: t('settings_controller.password_update_problem')
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
