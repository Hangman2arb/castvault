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
end
