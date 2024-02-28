class Manager::FormsController < ApplicationController
  before_action :authenticate_user!
  def index
    @title = t('forms_controller.index_title')
    @description = t('forms_controller.index_description')
    @header_buttons = [{ icon: 'plus-circle', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', link: new_manager_form_path, text: t('forms_controller.new_form') }]

    @forms = current_user.forms
    if @forms.any?

      @forms = @forms.search(params[:query], Form::SEARCHABLE_KEYS) if params[:query].present?
      @forms = @forms.reorder(Form.sort_column(params[:sort]) => Form.sort_direction(params[:direction]))

      @empty_content = { title: t('forms_controller.no_forms_yet'), message: t('forms_controller.no_forms_yet_description'), button_link: new_manager_form_path, button_icon: 'plus-circle', button_text: t('forms_controller.new_form'), main_icon: 'robot', data: { turbo_frame: '_top' } }


      @actions = {
        edit_link: {
          extra_options: { data: { turbo_track: "reload", turbo_frame: '_top' } }
        },
        show_link: {
          extra_options: { data: { turbo_track: "reload", turbo_frame: '_top' } }
        },
        destroy_link: {
          extra_options: { data: { turbo_frame: '_top', turbo_method: :delete, turbo_confirm: t('forms_controller.destroy_message').html_safe } }
        }
      }

      @excluded_keys = Form::KEYS_FOR_HIDE

    else
      @empty_content = { title: t('forms_controller.no_forms_yet'), message: t('forms_controller.no_forms_yet_description'), button_link: new_manager_form_path, button_icon: 'plus-circle', button_text: t('forms_controller.new_form'), main_icon: 'robot', data: { turbo_frame: '_top' } }
    end

    @pagy, @data_collection = pagy_array(get_form_collection(@forms), items: get_items, size: [1,2,2,1])
  end

  def new
    @title = t('forms_controller.new_title')
    @description = t('forms_controller.new_description')
    @header_buttons = [ { icon: 'save', type: 'submit', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', text: t('labels.save') },
                        { icon: 'arrow-90deg-left', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', link: manager_forms_path, text: t('labels.back_button') } ]

    @form = Form.new
  end

  def create
    @title = t('forms_controller.new_title')
    @description = t('forms_controller.new_description')
    @header_buttons = [ { icon: 'save', type: 'submit', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', text: t('labels.save') },
                        { icon: 'arrow-90deg-left', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', link: manager_forms_path, text: t('labels.back_button') } ]

    @form = Form.new(form_params)
    @form.user = current_user

    if @form.save
      redirect_to manager_forms_path, notice: t('forms_controller.form_created')
    else
      render :new
    end
  end


  def edit
    @title = t('forms_controller.edit_title')
    @description = form.name
    @header_buttons = [ { icon: 'save', type: 'submit', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', text: t('labels.update') },
                        { icon: 'arrow-90deg-left', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', link: manager_forms_path, text: t('labels.back_button') } ]

  end

  def update
    @title = t('forms_controller.edit_title')
    @description = form.name
    @header_buttons = [
      { icon: 'save', type: 'submit', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', text: t('labels.update') },
      { icon: 'arrow-90deg-left', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', link: manager_forms_path, text: t('labels.back_button') }
    ]

    if form.update(form_params)
      redirect_to manager_forms_path, notice: t('forms_controller.form_updated')
    else
      render :edit
    end
  end

  def show
    @title = 'Show form title'
    @description = 'Show form description'
    @header_buttons = [ { icon: 'send', type: 'submit', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', text: t('labels.send') },
                        { icon: 'arrow-90deg-left', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', link: manager_forms_path, text: t('labels.back_button') } ]

    @form = Form.find_by(id: params[:id])
    @profile = Profile.new

    @filtered_admited_form_fields = {}
    @filtered_featured_options = {}

    @form.ordered_fields.each do |key, value|
      if Form::ADMITED_FORM_FIELDS[key.to_sym]
        if value['include'] == 'true'
          @filtered_admited_form_fields[key.to_sym] = Form::ADMITED_FORM_FIELDS[key.to_sym]
        end
      end

      if Form::FEATURES_OPTIONS[key.to_sym]
        if value['include'] == 'true'
          @filtered_featured_options[key.to_sym] = Form::FEATURES_OPTIONS[key.to_sym]
        end
      end
    end

  end


  def destroy
    if form.destroy
      redirect_to manager_forms_path, notice: t('forms_controller.form_deleted')
    else
      redirect_to manager_forms_path, alert: t('forms_controller.form_not_deleted')
    end
  end

  def search_languages
    languages_options = Form::LANGUAGES_OPTIONS.map { |value, text| { value: text, text: t("forms_controller.multiselect_texts.languages.#{value}") } }
    render json: languages_options
  end

  def search_available_for
    available_for_options = Form::AVAILABLE_FOR_OPTIONS.map { |value| { value: value, text: t("forms_controller.multiselect_texts.available_for.#{value}") } }
    render json: available_for_options
  end


  private

  def get_form_collection forms
    result = []
    forms.each do |form|
      form_data_hash = {}
      Form::DATA_FOR_SHOW.each do |key|
        case key
        when :edit_link
          form_data_hash[key] = edit_manager_form_path(form)
        when :show_link
          form_data_hash[key] = manager_form_path(form)
        when :destroy_link
          form_data_hash[key] = manager_form_path(form)
        when :updated_at
          form_data_hash[key] = global_date_format(form[key].in_time_zone(current_user.time_zone))
        else
          form_data_hash[key] = form[key]
        end
      end
      result.push form_data_hash
    end
    result
  end

  def form
    @form ||= current_user.forms.find_by(id: params[:id])
  end

  def form_params
    permitted_keys = Form::ADMITED_FORM_FIELDS.keys + Form::FEATURES_OPTIONS.keys

    fields_params = (params.dig(:form, :fields) || {}).select { |key, _| permitted_keys.include?(key.to_sym) }

    params.require(:form).permit(:name).merge(fields: fields_params).permit!
  end


end
