class EmailCenteredButtonComponent < ViewComponent::Base
  def initialize(text: '', url: '#')
    @text = text
    @url = url
  end
end
