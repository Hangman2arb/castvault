class Manager::DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @title = 'Dashboard'
    @description = 'Ten una vista global de todos tus datos.'

    @profiles = current_user.profiles
    @forms = current_user.forms

    @total_profiles = @profiles.count
    @total_forms = @forms.count

    @forms_ordered_by_use = current_user.forms.joins(:profiles).group(:id).order('COUNT(profiles.id) DESC')
    @form_with_most_profiles = @forms_ordered_by_use.first
    @form_with_less_profiles = @forms_ordered_by_use.last

    @profiles_by_date = @profiles.group_by_day(:created_at).count
    @profiles_by_ethnicity = @profiles.group(:ethnicity).count.transform_keys do |key|
      I18n.t("ethnicities.#{key}", default: key.to_s.humanize)
    end
    @profiles_by_gender = @profiles.group(:gender).count.transform_keys do |key|
      I18n.t("genders.#{key}", default: key.to_s.humanize)
    end
    @hair_type_distribution = @profiles.group(:hair_type).count.transform_keys do |key|
      I18n.t("hair_types.#{key}", default: key.to_s.humanize)
    end
    @hair_color_distribution = @profiles.group(:hair_color).count.transform_keys do |key|
      I18n.t("hair_colors.#{key}", default: key.to_s.humanize)
    end
    @eye_color_distribution = @profiles.group(:eye_color).count.transform_keys do |key|
      I18n.t("eye_colors.#{key}", default: key.capitalize)
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

  end

end
