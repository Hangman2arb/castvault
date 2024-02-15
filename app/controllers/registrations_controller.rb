class RegistrationsController < Devise::RegistrationsController
  layout 'landing_page'
  before_action :configure_sign_up_params, only: [:create]

  def create
    super do |user|
      if user.persisted?
        begin
          user.create_default_setting(request.remote_ip)
        rescue Net::SMTPFatalError => e
          Rails.logger.error "Falló el envío de correo electrónico: #{e.message}"
        end
      end
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :terms_accepted])
  end
end