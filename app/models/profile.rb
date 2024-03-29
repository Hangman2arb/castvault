class Profile < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_name, against: {
    name: 'A',
    surname: 'B'
  },
  using: {
    tsearch: {
      prefix: true,
      dictionary: "simple"
    }
  },
  ignoring: :accents

  belongs_to :user
  validate :dynamic_fields_validation

  ORDER_BY = {
    newest: "created_at DESC",
    age_old: "birthdate DESC",
    age_young: "birthdate ASC"
  }

  has_one_attached :face_photo
  has_one_attached :body_photo
  has_one_attached :video_book

  belongs_to :form

  has_many :profile_tags
  has_many :tags, through: :profile_tags


  private

  def dynamic_fields_validation
    form.fields.each do |field, settings|
      next unless settings['include'] == 'true'

      value = send(field)
      field_settings = Form::ADMITED_FORM_FIELDS[field.to_sym] || {}

      next if Form::FEATURES_OPTIONS.keys.include?(field.to_sym)

      if value.blank?
        errors.add(field, I18n.t('show_form.errors.cant_be_blank'))
      else
        # Validación basada en el tipo de campo
        case field_settings[:type]
        when 'email'
          validate_email(field, value)
        when 'integer'
          validate_integer(field, value, field_settings)
        when 'date'
          validate_date(field, value)
        when 'string'
          validate_string(field, value, field_settings)
        when 'select', 'multiselect'
          validate_selection(field, value, field_settings[:options])
        when 'image', 'video'
          validate_attachment(field, send(field), field_settings)
        end
      end
    end
  end

  def validate_email(field, value)
    unless value =~ URI::MailTo::EMAIL_REGEXP
      errors.add(field, I18n.t('show_form.errors.invalid_email'))
    end
  end

  def validate_integer(field, value, settings)
    unless value.to_s =~ /\A[+-]?\d+\z/
      errors.add(field, I18n.t('show_form.errors.invalid_integer'))
    else
      value_int = value.to_i
      if value_int < settings[:min] || value_int > settings[:max]
        errors.add(field, I18n.t('show_form.errors.out_of_range', min: settings[:min], max: settings[:max]))
      end
    end
  end


  def validate_date(field, value)
    errors.add(field, I18n.t('show_form.errors.invalid_date')) unless value.is_a?(Date)
  end

  def validate_string(field, value, settings)
    max_length = settings[:max_length] || 255
    min_length = settings[:min_length] || 1
    if value.length > max_length || value.length < min_length
      errors.add(field, I18n.t('show_form.errors.invalid_string_length', min: min_length, max: max_length))
    end
  end

  def validate_selection(field, value, options)
    Array(value).each do |val|
      unless options.include?(val)
        errors.add(field, I18n.t('show_form.errors.invalid_selection'))
        break
      end
    end
  end

  def validate_attachment(field, value, settings)
    if value.attached?
      unless settings[:formats].include?(value.blob.content_type)
        errors.add(field, I18n.t('show_form.errors.invalid_format', formats: settings[:formats].join(', ')))
      end

      if value.blob.byte_size > settings[:max_size]
        errors.add(field, I18n.t('show_form.errors.file_too_large', max_size: settings[:max_size].to_s(:human_size)))
      end
    end
  end

end


