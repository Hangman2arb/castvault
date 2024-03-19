class InputComponent < ViewComponent::Base
  def initialize(form:, key:, model: nil, label: 'N/A', placeholder: '', type: 'text_field')
    @form = form
    @key = key
    @model = model
    @label = label
    @placeholder = placeholder
    @type = type
  end
end
