class FindProfiles
  attr_reader :profiles

  def initialize(current_user)
    @profiles = current_user.profiles.with_attached_face_photo
  end

  def call(params = {})
    scoped = profiles
    scoped = filter_by_name(scoped, params[:name])
    scoped = filter_by_form_id(scoped, params[:form_id])
    scoped = filter_by_min_age(scoped, params[:min_age])
    scoped = filter_by_max_age(scoped, params[:max_age])
    scoped = filter_by_min_height(scoped, params[:min_height])
    scoped = filter_by_max_height(scoped, params[:max_height])
    scoped = filter_by_min_shirt_size(scoped, params[:min_shirt_size])
    scoped = filter_by_max_shirt_size(scoped, params[:max_shirt_size])
    scoped = filter_by_min_pants_size(scoped, params[:min_pants_size])
    scoped = filter_by_max_pants_size(scoped, params[:max_pants_size])
    scoped = filter_by_min_shoe_size(scoped, params[:min_shoe_size])
    scoped = filter_by_max_shoe_size(scoped, params[:max_shoe_size])
    scoped = filter_by_gender(scoped, params[:gender])
    scoped = filter_by_ethnicity(scoped, params[:ethnicity])
    scoped = filter_by_hair_type(scoped, params[:hair_type])
    scoped = filter_by_hair_color(scoped, params[:hair_color])
    scoped = filter_by_eye_color(scoped, params[:eye_color])
    scoped = filter_by_city(scoped, params[:city])
    scoped = filter_by_agent_name(scoped, params[:agent_name])
    scoped = filter_by_availability(scoped, params[:available_for])
    scoped = filter_by_skills(scoped, params[:skills])
    sort(scoped, params[:order_by])
  end

  private

  def filter_by_name(scoped, name)
    return scoped unless name.present?

    scoped.search_by_name(name)
  end

  def filter_by_form_id(scoped, form_id)
    return scoped unless form_id.present?

    scoped.where(form_id: form_id)
  end

  def filter_by_min_age(scoped, min_age)
    return scoped if min_age.blank? || min_age.to_i <= 0

    min_birthdate = Date.today - min_age.to_i.years
    scoped.where("birthdate <= ?", min_birthdate)
  end

  def filter_by_max_age(scoped, max_age)
    return scoped if max_age.blank? || max_age.to_i >= 100

    max_birthdate = Date.today - (max_age.to_i + 1).years
    scoped.where("birthdate > ?", max_birthdate)
  end

  def filter_by_min_height(scoped, min_height)
    return scoped if min_height.blank? || min_height.to_i <= 40

    scoped.where("height >= ?", min_height.to_i)
  end

  def filter_by_max_height(scoped, max_height)
    return scoped if max_height.blank? || max_height.to_i >= 220

    scoped.where("height <= ?", max_height.to_i)
  end

  def filter_by_min_shirt_size(scoped, min_shirt_size)
    return scoped if min_shirt_size.blank? || min_shirt_size.to_i <= 1

    scoped.where("shirt_size >= ?", min_shirt_size.to_i)
  end

  def filter_by_max_shirt_size(scoped, max_shirt_size)
    return scoped if max_shirt_size.blank? || max_shirt_size.to_i >= 74

    scoped.where("shirt_size <= ?", max_shirt_size.to_i)
  end

  def filter_by_min_pants_size(scoped, min_pants_size)
    return scoped if min_pants_size.blank? || min_pants_size.to_i <= 1

    scoped.where("pants_size >= ?", min_pants_size.to_i)
  end

  def filter_by_max_pants_size(scoped, max_pants_size)
    return scoped if max_pants_size.blank? || max_pants_size.to_i >= 70

    scoped.where("pants_size <= ?", max_pants_size.to_i)
  end

  def filter_by_min_shoe_size(scoped, min_shoe_size)
    return scoped if min_shoe_size.blank? || min_shoe_size.to_i <= 16

    scoped.where("shoe_size >= ?", min_shoe_size.to_i)
  end

  def filter_by_max_shoe_size(scoped, max_shoe_size)
    return scoped if max_shoe_size.blank? || max_shoe_size.to_i >= 54

    scoped.where("shoe_size <= ?", max_shoe_size.to_i)
  end

  def filter_by_gender(scoped, gender)
    return scoped unless gender.present?

    scoped.where(gender: gender)
  end

  def filter_by_city(scoped, city)
    return scoped unless city.present?

    scoped.where(city: city)
  end

  def filter_by_agent_name(scoped, agent_name)
    return scoped unless agent_name.present?

    if agent_name == 'no_agency'
      scoped.where(agency: [false, nil])
    else
      scoped.where("unaccent(lower(agent_name)) = unaccent(lower(?))", agent_name)
    end
  end

  def filter_by_availability(scoped, available_for)
    return scoped unless available_for.present?
    available_for_clean = available_for.reject { |value| value == '0' }
    return scoped if available_for_clean.blank?

    available_for_json = available_for_clean.to_json

    scoped.where("CAST(available_for AS jsonb) @> ?", available_for_json)
  end


  def filter_by_skills(scoped, skills_params)
    return scoped unless skills_params.present?
    return scoped if skills_params.blank?

    skills_params.each do |category, values|
      values_clean = values.reject { |value| value == '0' }
      next if values_clean.blank?

      values_json = values_clean.to_json
      scoped = scoped.where("CAST(#{category} AS jsonb) @> ?", values_json)
    end
    scoped
  end

  def filter_by_ethnicity(scoped, ethnicity)
    return scoped unless ethnicity.present?

    scoped.where(ethnicity: ethnicity)
  end

  def filter_by_hair_type(scoped, hair_type)
    return scoped unless hair_type.present?

    scoped.where(hair_type: hair_type)
  end

  def filter_by_hair_color(scoped, hair_color)
    return scoped unless hair_color.present?

    scoped.where(hair_color: hair_color)
  end

  def filter_by_eye_color(scoped, eye_color)
    return scoped unless eye_color.present?

    scoped.where(eye_color: eye_color)
  end

  def sort(scoped, order_by)
    order_by_query = Profile::ORDER_BY.fetch(order_by&.to_sym, Profile::ORDER_BY[:newest])
    scoped.order(order_by_query)
  end

end