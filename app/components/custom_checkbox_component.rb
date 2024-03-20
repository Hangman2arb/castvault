class CustomCheckboxComponent < ViewComponent::Base
  def initialize(form:, key:, value: nil, checked: false, model: nil, label: '', info_message: nil)
    @form = form
    @key = key
    @value = value
    @checked = checked
    @model = model
    @label = label
    @info_message = info_message
  end
end
