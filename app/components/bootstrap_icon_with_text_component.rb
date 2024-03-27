class BootstrapIconWithTextComponent < ViewComponent::Base
  def initialize(icon: 'exclamation-triangle-fill', text: '', extra_classes: 'text-xl', icon_position: 'left', text_extra_classes: 'text-sm', button_extra_classes: nil)
    @icon = icon
    @text = text
    @extra_classes = extra_classes
    @icon_position = icon_position
    @text_extra_classes = text_extra_classes
    @button_extra_classes = button_extra_classes
  end
end
