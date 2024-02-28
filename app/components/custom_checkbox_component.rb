class CustomCheckboxComponent < ViewComponent::Base
  def initialize(form:, key:, value:, checked: false)
    @form = form
    @key = key
    @value = value
    @checked = checked
  end
end
