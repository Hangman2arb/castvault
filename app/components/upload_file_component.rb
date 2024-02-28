class UploadFileComponent < ViewComponent::Base
  def initialize(form:, model:, attribute:, label: nil, multiple: false, icon: 'list', accepted_types: %w[png jpg gif], max_size_mb: 10, extra_actions: [])
    @form = form
    @model = model
    @attribute = attribute
    @label = label
    @multiple = multiple
    @icon = icon
    @accepted_types = accepted_types
    @max_size_mb = max_size_mb
    @extra_actions = extra_actions.join(' ')

    @is_attached = form.object.send(attribute).attached?
    @image_url = @is_attached ? Rails.application.routes.url_helpers.url_for(form.object.send(attribute)) : nil
  end

  def accepted_types_to_mime
    @accepted_types.map { |type| "image/#{type}" }.join(', ')
  end

  def accepted_types_message
    "#{@accepted_types.join(', ').upcase} up to #{@max_size_mb}MB"
  end
end
