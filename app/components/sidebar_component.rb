class SidebarComponent < ViewComponent::Base
  def initialize(current_user:)
    @menu_items = [
      { route: "/manager", text: I18n.t('sidebar_component.dashboard'), icon: "speedometer2", menu_option_id: "dashboard" },
      { route: "/manager/profiles", text: I18n.t('sidebar_component.profiles'), icon: "person-bounding-box", menu_option_id: "profiles" },
      { route: "/manager/forms", text: I18n.t('sidebar_component.forms'), icon: "ui-checks", menu_option_id: "forms" },
      { route: "/manager/clients", text: I18n.t('sidebar_component.clients'), icon: "people-fill", menu_option_id: "clients" },
      { route: "/manager/settings", text: I18n.t('sidebar_component.settings'), icon: "gear", menu_option_id: "settings" },
    ]
    @current_user = current_user
  end

  def menu_item_class(menu_option_id)
    menu_option_id == params[:menu_option_id] ? "bg-gray-800 text-primary" : "text-gray-200 hover:text-light hover:bg-gray-800"
  end
end