class Category < ApplicationRecord
  extend FriendlyId
  extend FriendlyId::Finders
  friendly_id :slug, use: [:slugged, :finders]

  has_ancestry

  validates :name, presence: true, uniqueness: true
end
