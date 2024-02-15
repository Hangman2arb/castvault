module Utilities
  extend ActiveSupport::Concern

  included do
    def get_items
      params[:count].present? ? params[:count] : 10
    end
  end
end