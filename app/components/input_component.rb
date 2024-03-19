class InputComponent < ViewComponent::Base
  def initialize(form: nil, key: nil, model: nil, label: 'N/A', placeholder: 'N/A')
    @form = form
    @key = key
    @model = model
    @label = label
    @placeholder = placeholder
  end
end