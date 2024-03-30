module ApplicationHelper
  include Pagy::Frontend
  include ActionView::Helpers::NumberHelper

  def sort_link_to(header)
    direction = params[:direction] == 'asc' && params[:sort] == header.to_s ? 'desc' : 'asc'
    icon_class = direction == 'desc' ? 'bi-caret-up' : 'bi-caret-down'
    icon = content_tag(:i, '', class: "bi #{icon_class} text-sm mt-1 ml-2")
    link_content = content_tag(:div, class: 'flex items-center') do
      content_tag(:span, t("data_table_component.#{header}")) + icon
    end
    link_to link_content, request.params.merge(sort: header, direction: direction), class: 'sort-link', remote: true
  end

  def global_datetime_format(date)
    if date
      date.strftime('%d / %m / %Y - %H:%M')
    else
      t('.no_date_found')
    end
  end

  def global_date_format(date)
    if date
      date.strftime('%d / %m / %Y')
    else
      t('.no_date_found')
    end
  end

  def global_price_format(price)
    return '0 €' unless price

    number_to_currency(price, unit: '€', separator: ",", delimiter: ".", format: "%n %u")
  end

  def custom_time_select(form, field)
    hours = (0..23).to_a.map { |h| h.to_s.rjust(2, '0') }
    minutes = ['00', '30']

    # Obtén la hora y los minutos del valor actual del campo
    current_value = form.object.send(field)
    current_hour = current_value ? current_value.strftime('%H') : ''
    current_minute = current_value ? current_value.strftime('%M') : ''

    hour_options = options_for_select(hours, current_hour)
    minute_options = options_for_select(minutes, current_minute)

    form.select("#{field}(4i)", hour_options) +
      ":" +
      form.select("#{field}(5i)", minute_options)
  end

end
