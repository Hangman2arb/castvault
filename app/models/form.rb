class Form < ApplicationRecord
  include Searchable

  belongs_to :user
  has_many :profiles

  has_one_attached :description_photo

  validates :name, presence: true

  before_create :generate_unique_token


  DATA_FOR_SHOW = [ :id, :name, :submissions_count, :updated_at, :edit_link, :destroy_link, :copy_form_link ] #, :show_link
  KEYS_FOR_HIDE = [:id, :edit_link, :destroy_link, :copy_form_link] #, :show_link
  SEARCHABLE_KEYS  = ['name']
  SORTING_KEYS  = ['name']

  EXCLUDED_KEYS = %w[id created_at updated_at]

  ETHNICITY_OPTIONS = %w[asian black_african caucasian hispanic_latino middle_eastern native_american pacific_islander mixed other]
  GENDER_OPTIONS = %w[male female non_binary]
  LANGUAGES_OPTIONS = %w[en fr de es it ru pl nl tr sv]
  HAIR_TYPE_OPTIONS = %w[bald straight open_wave wavy curly very_curly coiled very_coiled zigzag_coiled]
  HAIR_COLOR_OPTIONS = %w[blonde light_brown red medium_brown dark_brown black gray white]
  EYE_COLOR_OPTIONS = %w[amber blue brown gray green hazel]
  FEATURES_OPTIONS = {
    sports_outdoor: ["mountain_surf", "running", "cycling", "snowboard", "ski", "climbing", "roller_skating", "skate", "tennis"],
    sports_watersports: ["diving", "surf", "paddle_surf", "kite_surf", "wind_surf", "sail"],
    sports_martial_arts: ["taekwondo", "karate", "judo", "jujitsu", "tai_chi", "aikido", "kendo", "kung_fu", "kickboxing"],
    sports_gymnastics: ["aerobics", "yoga", "fitness", "zumba", "boxing", "crossfit", "acrogym"],
    sports_extreme: ["parachuting", "acrobatics", "freefall", "jump", "ultra_light_flying", "rafting", "speleology", "parkour"],
    sports_team: ["football", "volleyball", "baseball", "hockey", "basketball"],
    sports_underwater: ["apnea", "diving", "snorkel"],
    arts_leisure_music: ["singing", "piano", "violin", "violoncello", "drums", "guitar", "bass", "flute"],
    arts_leisure_dance: ["hip_hop", "popping", "break_dance", "jazz", "ballet", "contemporary", "voguing", "pole_dance", "dancehall", "afrobeat", "flamenco"],
    arts_leisure_stunt_professions: ["precision_driver", "equilibrist", "cooking"],
    general: ["acting", "modeling", "music", "dancing", "sports"]
  }
  AVAILABLE_FOR_OPTIONS = %w[performing_arts tv fiction advertising]

  ADMITED_FORM_FIELDS = {
    name: { type: 'string', section: 'basic_information' },
    surname: { type: 'string', section: 'basic_information' },
    email: { type: 'email', section: 'basic_information' },
    phone: { type: 'string', section: 'basic_information' },
    birthdate: { type: 'date', section: 'basic_information' },
    ethnicity: { type: 'select', options: ETHNICITY_OPTIONS, section: 'basic_information' },
    gender: { type: 'select', options: GENDER_OPTIONS, section: 'basic_information' },
    city: { type: 'string', section: 'basic_information' },
    languages: { type: 'multiselect', options: LANGUAGES_OPTIONS, section: 'basic_information' },
    is_an_actor: { type: 'boolean', section: 'basic_information' },

    agency: { type: 'boolean', section: 'contact_information' },
    agent_name: { type: 'string', section: 'contact_information' },
    agent_email: { type: 'email', section: 'contact_information' },
    agent_phone: { type: 'string', section: 'contact_information' },

    height: { type: 'integer', section: 'measurements', min: 40, max: 220 },
    shirt_size: { type: 'integer', section: 'measurements', min: 1, max: 74 },
    pants_size: { type: 'integer', section: 'measurements', min: 1, max: 70 },
    shoe_size: { type: 'integer', section: 'measurements', min: 16, max: 54 },

    passport: { type: 'boolean', section: 'additional_information' },
    driving_license: { type: 'boolean', section: 'additional_information' },
    hair_type: { type: 'select', options: HAIR_TYPE_OPTIONS, section: 'additional_information' },
    hair_color: { type: 'select', options: HAIR_COLOR_OPTIONS, section: 'additional_information' },
    eye_color: { type: 'select', options: EYE_COLOR_OPTIONS, section: 'additional_information' },
    food_allergies: { type: 'string', section: 'additional_information' },
    available_for: { type: 'multiselect', options: AVAILABLE_FOR_OPTIONS, section: 'additional_information' },

    web: { type: 'string', section: 'social_media' },
    twitter: { type: 'string', section: 'social_media' },
    facebook: { type: 'string', section: 'social_media' },
    instagram: { type: 'string', section: 'social_media' },
    tik_tok: { type: 'string', section: 'social_media' },

    face_photo: { type: 'image', section: 'pictures_and_media', formats: ['image/png', 'image/jpg', 'image/jpeg', 'image/heic'], max_size: 10.megabytes },
    body_photo: { type: 'image', section: 'pictures_and_media', formats: ['image/png', 'image/jpg', 'image/jpeg', 'image/heic'], max_size: 10.megabytes },
    video_book: { type: 'video', section: 'pictures_and_media', formats: ['video/mov', 'video/mp4', 'video/avi'], max_size: 100.megabytes },
  }

  FIELDS_ORDER = [
    :name, :surname, :email, :phone, :birthdate, :ethnicity,
    :gender, :city, :languages, :is_an_actor, :agency, :agent_name,
    :agent_email, :agent_phone, :height, :shirt_size, :pants_size,
    :shoe_size, :passport, :driving_license, :hair_type, :hair_color,
    :eye_color, :food_allergies, :available_for, :web, :twitter,
    :facebook, :instagram, :tik_tok, :face_photo, :body_photo,
    :video_book, :sports_outdoor, :sports_watersports, :sports_martial_arts,
    :sports_gymnastics, :sports_extreme, :sports_team,
    :sports_underwater, :arts_leisure_music, :arts_leisure_dance,
    :arts_leisure_stunt_professions, :general
  ].freeze

  INPUT_TYPES = {
    'string' => 'text_field',
    'email' => 'email_field',
    'integer' => 'number_field',
    'date' => 'date_field'
  }.freeze

  def ordered_fields
    ordered = FIELDS_ORDER.map do |key|
      [key, fields[key.to_s]] if fields.has_key?(key.to_s)
    end.compact.to_h
  end

  private

  def generate_unique_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless Form.exists?(token: random_token)
    end
  end
end
