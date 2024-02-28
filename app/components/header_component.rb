class HeaderComponent < ViewComponent::Base
  def initialize(title: 'Sin título', description: 'Sin descripción', buttons: [])
    @title = title
    @description = description
    @buttons = buttons
    @mobile_menu_buttons = if buttons.size > 2
                             buttons[1..-1]
                           else
                             []
                           end

    @index_condition = @buttons.size - (1+@mobile_menu_buttons.size)
  end

  def link_path button
    button[:link].present? ? button[:link] : nil
  end

  def classes button
    button[:class].present? ? button[:class] : ''
  end

  def data_attr button
    button[:data].present? ? button[:data] : {}
  end

  def bootstrap_icon button
    button[:icon].present? ? button[:icon] : 'caret-right'
  end

  def text button
    button[:text].present? ? button[:text] : 'NO TEXT DEFINED'
  end

  def classes_by_index index
    index == 0 ? 'inline-flex items-center rounded-full bg-primary px-4 py-3 text-md font-medium text-white transition duration-200 cursor-pointer hover:bg-dark hover:transition-all focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600' : 'inline-flex items-center rounded-3xl bg-white px-4 py-3 text-md font-medium text-shadowy-300 transition duration-200 cursor-pointer hover:bg-shadowy-100 hover:transition-all focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-gray-600'
  end

  def get_method button
    button[:method].present? ? button[:method] : :get
  end

  def button_type button
    button[:type].present? ? button[:type] : 'button'
  end
end
