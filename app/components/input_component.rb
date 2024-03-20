class InputComponent < ViewComponent::Base
  def initialize(form:, key:, model: nil, label: nil, placeholder: '', type: 'text_field', info_message: nil)
    @form = form
    @key = key
    @model = model
    @label = label
    @placeholder = placeholder
    @type = type
    @info_message = info_message
  end
end
