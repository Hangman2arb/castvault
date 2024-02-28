class ButtonComponent < ViewComponent::Base
  def initialize(text: 'No Text', action: '#', icon: nil, bg_color: 'bg-primary', bg_color_hover: 'bg-dark', text_color: 'text-light', text_color_hover: 'text-light', icon_extra_classes: 'text-2xl', is_link: false, additional_attributes: {}, button_type: 'button', w_full: false)
    @text = text
    @action = action
    @icon = icon
    @bg_color = bg_color
    @bg_color_hover = bg_color_hover
    @text_color = text_color
    @text_color_hover = text_color_hover
    @icon_extra_classes = icon_extra_classes
    @method = is_link ? :link_to : :button_to
    @additional_attributes = additional_attributes
    @button_type = button_type
    @w_full = w_full
  end
end
