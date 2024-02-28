class Tag < ApplicationRecord
  has_many :profile_tags
  has_many :profiles, through: :profile_tags
end
