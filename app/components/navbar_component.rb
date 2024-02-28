# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  def initialize
    @links = [
      { name: "Product", url: "#product" },
      { name: "Features", url: "#features" },
      { name: "Marketplace", url: "#marketplace" },
      { name: "Company", url: "#company" }
    ]
  end
end
