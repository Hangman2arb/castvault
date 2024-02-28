class SliderComponent < ViewComponent::Base
  def initialize(selected_val_min: 0, val_min: 0, key_min:, selected_val_max: 100, val_max: 100, key_max:, form:)
    @val_min = val_min
    @selected_val_min = selected_val_min
    @key_min = key_min
    @val_max = val_max
    @selected_val_max = selected_val_max
    @key_max = key_max
    @form = form
  end
end
