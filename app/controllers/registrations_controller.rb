class RegistrationsController < Devise::RegistrationsController
  layout 'web'
  before_action :configure_sign_up_params, only: [:create]

  def create
    super do |user|
      if user.persisted?
        SetUserTimeZoneAndLanguageJob.perform_async(user.id, request.remote_ip)
      end
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :terms_accepted])
  end
end