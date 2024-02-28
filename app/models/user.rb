class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :forms
  has_many :profiles

  enum role: [:user, :admin]
  enum plan: [:basic, :pro, :elite]

  has_one_attached :profile_photo

  PLATFORM_LANGUAGES = {
    'es' => 'Español',
    'ca' => 'Català',
    'en' => 'English',
    'ru' => 'Русский',
    'pt' => 'Português',
    'fr' => 'Français',
    'de' => 'Deutsch'
  }.freeze
end
