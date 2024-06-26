module DeviseCustomParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      if resource.is_a?(User)
        stored_location_for(resource) || manager_root_path
      else
        root_path
      end
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name])
    end
  end
end