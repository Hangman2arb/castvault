class Manager::DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @title = I18n.t('dashboard_controller.title')
    @description = I18n.t('dashboard_controller.description')

    @profiles = current_user.profiles
    @forms = current_user.forms

    @total_profiles = @profiles.count
    @total_forms = @forms.count

    @forms_ordered_by_use = current_user.forms.joins(:profiles).group(:id).order('COUNT(profiles.id) DESC')
    @form_with_most_profiles = @forms_ordered_by_use.first
    @form_with_less_profiles = @forms_ordered_by_use.last

    @profiles_by_date = @profiles.group_by_day(:created_at).count
    @profiles_by_ethnicity = @profiles.group(:ethnicity).count.reject { |key, _| key.blank? }.transform_keys do |key|
      I18n.t("ethnicities.#{key}", default: key.to_s.humanize)
    end
    @profiles_by_gender = @profiles.group(:gender).count.reject { |key, _| key.blank? }.transform_keys do |key|
      I18n.t("genders.#{key}", default: key.to_s.humanize)
    end
    @hair_type_distribution = @profiles.group(:hair_type).count.reject { |key, _| key.blank? }.transform_keys do |key|
      I18n.t("hair_types.#{key}", default: key.to_s.humanize)
    end
    @hair_color_distribution = @profiles.group(:hair_color).count.reject { |key, _| key.blank? }.transform_keys do |key|
      I18n.t("hair_colors.#{key}", default: key.to_s.humanize)
    end
    @eye_color_distribution = @profiles.group(:eye_color).count.reject { |key, _| key.blank? }.transform_keys do |key|
      I18n.t("eye_colors.#{key}", default: key.to_s.capitalize)
    end


    @agency_distribution = @profiles.group(:agency).count.transform_keys do |key|
      key ? I18n.t('labels.yes') : I18n.t('labels.no')
    end

    @passport_distribution = @profiles.group(:passport).count.transform_keys do |key|
      key ? I18n.t('labels.yes') : I18n.t('labels.no')
    end

    @driving_license_distribution = @profiles.group(:driving_license).count.transform_keys do |key|
      key ? I18n.t('labels.yes') : I18n.t('labels.no')
    end

    @charts = [
      # Crecimiento de Perfiles
      { chart_type: 'line_chart', data: @profiles_by_date, key: 'profiles_by_date', options: line_chart_options, section: t('dashboard_controller.sections.profile_growth') },

      # Demografía
      { chart_type: 'bar_chart', data: @profiles_by_ethnicity, key: 'profiles_by_ethnicity', options: bar_options, section: t('dashboard_controller.sections.demographics') },
      { chart_type: 'pie_chart', data: @profiles_by_gender, key: 'profiles_by_gender', options: pie_chart_options, section: t('dashboard_controller.sections.demographics') },

      # Distribución de Características Físicas
      { chart_type: 'bar_chart', data: @hair_type_distribution, key: 'hair_type', options: bar_options, section: t('dashboard_controller.sections.physical_features') },
      { chart_type: 'bar_chart', data: @hair_color_distribution, key: 'hair_color', options: bar_options, section: t('dashboard_controller.sections.physical_features') },
      { chart_type: 'bar_chart', data: @eye_color_distribution, key: 'eye_color', options: bar_options, section: t('dashboard_controller.sections.physical_features') },

      # Información de Agencia y Documentación
      { chart_type: 'pie_chart', data: @agency_distribution, key: 'agency', options: pie_chart_options, section: t('dashboard_controller.sections.agency_and_documentation') },
      { chart_type: 'pie_chart', data: @passport_distribution, key: 'passport', options: pie_chart_options, section: t('dashboard_controller.sections.agency_and_documentation') },
      { chart_type: 'pie_chart', data: @driving_license_distribution, key: 'driving_license', options: pie_chart_options, section: t('dashboard_controller.sections.agency_and_documentation') }
    ]


    @cards = [
      ['total_profiles', @total_profiles],
      ['total_forms', @total_forms],
      ['most_used_form', "#{@form_with_most_profiles&.name} (#{@form_with_most_profiles&.profiles&.count})"],
      ['least_used_form', "#{@form_with_less_profiles&.name} (#{@form_with_less_profiles&.profiles&.count})"]
    ]

  end

  private

  def chart_colors
    ["#0ad1c4", "#ff6f61", "#fdd456", "#4dd0e1", "#ff8a65", "#d4e157", "#ba68c8", "#4db6ac", "#7986cb", "#a1887f"]
  end

  def border_color
    '#111827'
  end

  def pie_chart_options
    { donut: true, colors: chart_colors, dataset: { borderColor: border_color, borderWidth: 5 }, legend: false, loading: t('dashboard_controller.loading') }
  end

  def bar_options
    { label: t('dashboard_controller.value'), colors: chart_colors, dataset: { borderColor: border_color, borderWidth: 1 }, loading: t('dashboard_controller.loading') }
  end

  def line_chart_options
    { label: t('dashboard_controller.value'), curve: false , colors: ['#0ad1c4'], legend: false, loading: t('dashboard_controller.loading') }
  end

end
