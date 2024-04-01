class Manager::FormsController < ApplicationController
  before_action :authenticate_user!, except: [:show_form, :thank_you_page]

  layout 'form', only: [:show_form, :thank_you_page, :unavailable_page]
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
        copy_form_link: {
          extra_options: { data: { controller: 'copy-link-modal', action: 'click->copy-link-modal#showModal' } }
        },
        edit_link: {
          extra_options: { data: { turbo_track: "reload", turbo_frame: '_top' } }
        },
        # show_link: {
        #   extra_options: { data: { turbo_track: "reload", turbo_frame: '_top' } }
        # },
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

    modified_form_params = form_params
    modified_form_params[:available_until] = convert_date(modified_form_params[:available_until])

    @form = Form.new(modified_form_params)
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

    modified_form_params = form_params
    modified_form_params[:available_until] = convert_date(modified_form_params[:available_until])

    if form.update(modified_form_params)
      redirect_to manager_forms_path, notice: t('forms_controller.form_updated')
    else
      render :edit
    end
  end

  def show
    @title = I18n.t('forms_controller.show_title')
    @description = I18n.t('forms_controller.show_description')

    @header_buttons = [ { icon: 'send', type: 'submit', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', text: t('labels.send') },
                        { icon: 'arrow-90deg-left', class: 'inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-shadowy-300 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50', link: manager_forms_path, text: t('labels.back_button') } ]

    @form = current_user.forms.find_by(id: params[:id])
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

  def show_form
    @form = Form.find_by(token: params[:token])
    return render plain: t('forms_controller.not_found'), status: :not_found unless @form

    if !@form.available_until.present? || Date.current > @form.available_until
      return redirect_to unavailable_page_path(token: @form.token)
    end

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

  def thank_you_page
    @form = Form.find_by(token: params[:token])
    @home_page_link = @form.user.web_link
  end

  def unavailable_page
    @form = Form.find_by(token: params[:token])
    @home_page_link = @form.user.web_link
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
        when :copy_form_link
          form_data_hash[key] = form.token
        when :edit_link
          form_data_hash[key] = edit_manager_form_path(form)
        # when :show_link
        #   form_data_hash[key] = manager_form_path(form)
        when :destroy_link
          form_data_hash[key] = manager_form_path(form)
        when :available_until
          form_data_hash[key] = form_data_hash[key] = global_date_format(form[key])
        when :availability
          if form[:available_until]
            if form[:available_until].to_date >= Date.today
              form_data_hash[key] = BadgeComponent.new(text: t('data_table_component.available'), type: 'green')
            else
              form_data_hash[key] = BadgeComponent.new(text: t('data_table_component.unavailable'), type: 'red')
            end
          else
            form_data_hash[key] = BadgeComponent.new(text: t('data_table_component.unavailable'), type: 'red')
          end
        when :name
          image_url = form.description_photo.attached? ? url_for(form.description_photo) : nil
          form_data_hash[key] = AvatarComponent.new(image_url: image_url, size: :large, text: form[key], zoomable: true).render_in(view_context)
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

    params.require(:form).permit(:name, :description, :description_photo, :available_until).merge(fields: fields_params).permit!
  end


end
