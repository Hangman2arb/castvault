class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :forms
  has_many :profiles

  enum role: [:user, :admin, :client]
  enum plan: [:basic, :pro, :elite]

  has_one_attached :profile_photo

  scope :clients, ->(user) { where(invited_by: user) }

  PLATFORM_LANGUAGES = {
    'es' => 'Español',
    'ca' => 'Català',
    'en' => 'English',
    'ru' => 'Русский',
    'pt' => 'Português',
    'fr' => 'Français',
    'de' => 'Deutsch'
  }.freeze

  def full_name
    "#{first_name} #{last_name}"
  end
end
