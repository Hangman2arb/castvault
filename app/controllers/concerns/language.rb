module Language
  extend ActiveSupport::Concern

  included do
    before_action :set_locale

    SUPPORTED_LANGUAGES = Setting::PLATFORM_LANGUAGES.keys

    private

    def set_locale
      if user_signed_in?
        user_locale = current_user&.setting&.language
        session[:locale] = user_locale if SUPPORTED_LANGUAGES.include?(user_locale)
      else
        session[:locale] ||= locale_from_header
      end

      I18n.locale = session[:locale] || 'en'
    end

    def locale_from_header
      request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    end

    def after_sign_in_path_for(resource)
      set_locale_for_user(resource)
      super
    end

    private

    def set_locale_for_user(user)
      user_locale = user.setting.language if user.respond_to?(:setting)
      I18n.locale = SUPPORTED_LANGUAGES.include?(user_locale) ? user_locale : 'en'
    end
  end
end
