class SelectComponent < ViewComponent::Base
  def initialize(form: nil, key: nil, options_for_select: [], model: nil, label: 'N/A', placeholder: 'N/A', multiple: false, info_message: nil)
    @form = form
    @key = key
    @model = model
    @label = label
    @placeholder = placeholder
    @options_for_select = options_for_select
    @multiple = multiple
    @info_message = info_message
  end
end
