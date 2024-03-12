class CustomCheckboxComponent < ViewComponent::Base
  def initialize(form:, key:, value: nil, checked: false)
    @form = form
    @key = key
    @value = value
    @checked = checked
  end
end
