class SidebarComponent < ViewComponent::Base
  def initialize(current_user:)
    @menu_items = [
      { route: "/manager", text: "Dashboard", icon: "speedometer2", menu_option_id: "dashboard" },
      { route: "/manager/profiles", text: "Perfiles", icon: "person-bounding-box", menu_option_id: "profiles" },
      { route: "/manager/forms", text: "Formulario", icon: "ui-checks", menu_option_id: "forms" },
      { route: "/manager/clients", text: "Clientes", icon: "people-fill", menu_option_id: "clients" },
      { route: "/manager/settings", text: "Settings", icon: "gear", menu_option_id: "settings" },
    ]
    @current_user = current_user
  end

  def menu_item_class(menu_option_id)
    menu_option_id == params[:menu_option_id] ? "bg-gray-800 text-primary" : "text-gray-200 hover:text-light hover:bg-gray-800"
  end
end