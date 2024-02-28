# frozen_string_literal: true

class DataTableComponent < ViewComponent::Base
  include ApplicationHelper
  include Turbo::FramesHelper
  def initialize(data_collection: [], pagy: [], actions: [], excluded_keys: [], empty_content: {}, sorting_keys: [], date_range_picker: false, under_filters_content: nil, form_action: '', selector_options: nil)
    @headers = data_collection.first&.except(*excluded_keys)&.keys
    @data_collection = data_collection
    @pagy = pagy
    @actions = actions
    @excluded_keys = excluded_keys
    @empty_content = empty_content
    @sorting_keys = sorting_keys
    @date_range_picker = date_range_picker
    @under_filters_content = under_filters_content
    @form_action = form_action
    @selector_options = selector_options
  end

  def render_content(data)
    if data.is_a?(Hash) && data[:link]
      # If is a hash with :link, render a link using 'link_to' function
      link_to data[:value].blank? ? '-' : data[:value], data[:link], class: data[:class]
    elsif data.class.to_s.include?('Component')
      # Render the Component
      render(data)
    else
      # Otherwise print the data
      data.blank? ? '-' : data
    end
  end
end

