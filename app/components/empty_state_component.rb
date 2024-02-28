class EmptyStateComponent < ViewComponent::Base
  def initialize(empty_content = {})
    @empty_content = empty_content
  end

  def main_icon
    @empty_content[:main_icon].present? ? @empty_content[:main_icon] : 'info-circle'
  end

  def title
    @empty_content[:title].present? ? @empty_content[:title] : 'NO SOMETHING'
  end

  def message
    @empty_content[:message].present? ? @empty_content[:message].html_safe : 'NO SOMETHING MESSAGE'
  end

  def button_link
    @empty_content[:button_link].present? ? @empty_content[:button_link] : nil
  end

  def button_class
    @empty_content[:button_class].present? ? @empty_content[:button_class] : "inline-flex items-center rounded-full bg-primary px-4 py-3 text-md font-medium text-white transition duration-200 cursor-pointer hover:bg-dark hover:transition-all focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-dark mt-4"
  end

  def button_icon
    @empty_content[:button_icon].present? ? @empty_content[:button_icon] : 'plus-circle'
  end

  def button_text
    @empty_content[:button_text].present? ? @empty_content[:button_text] : 'NO BUTTON TEXT'
  end

  def data_attributes
    @empty_content[:data].present? ? @empty_content[:data] : {}
  end
end
