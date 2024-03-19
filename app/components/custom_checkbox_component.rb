class CustomCheckboxComponent < ViewComponent::Base
  def initialize(form:, key:, value: nil, checked: false, model: nil, label: '')
    @form = form
    @key = key
    @value = value
    @checked = checked
    @model = model
    @label = label
  end
end
