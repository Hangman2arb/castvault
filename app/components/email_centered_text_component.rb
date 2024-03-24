class EmailCenteredTextComponent < ViewComponent::Base
  def initialize(padding: '10px 25px', font_size: '16px', line_height: '22px', extra_styles: '', text: '')
    @padding = padding
    @font_size = font_size
    @line_height = line_height
    @extra_styles = extra_styles
    @text = text
  end
end
