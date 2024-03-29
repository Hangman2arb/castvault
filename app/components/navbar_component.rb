# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  def initialize
    @links = [
      { name: I18n.t('nav_component.product'), url: "#product" },
      { name: I18n.t('nav_component.features'), url: "#features" },
      { name: I18n.t('nav_component.pricing'), url: "#pricing" }
    ]
  end

end
