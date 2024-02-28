class DateRangePickerComponent < ViewComponent::Base
  def initialize(form:, value: nil)
    @form = form
    @input_attributes = {
      value: value,
      type: 'text',
      size: '24',
      class: 'w-fit flex text-center rounded-3xl border-0 bg-white px-4 py-3 text-shadowy-300 ml-2 transition duration-150 linear focus:ring-1 focus:ring-shadowy-100 focus:shadow-md ',
      data: {
        controller: "date-range-picker",
        today: I18n.t('date_range_picker.today'),
        yesterday: I18n.t('date_range_picker.yesterday'),
        last_seven_days: I18n.t('date_range_picker.last_seven_days'),
        last_thirty_days: I18n.t('date_range_picker.last_thirty_days'),
        this_month: I18n.t('date_range_picker.this_month'),
        last_month: I18n.t('date_range_picker.last_month'),
        last_three_sixty_five_days: I18n.t('date_range_picker.last_three_sixty_five_days'),
        action: 'change->autosave#save'
      }
    }
  end
end
