class Category < ApplicationRecord
  extend FriendlyId
  extend FriendlyId::Finders
  friendly_id :slug, use: [:slugged, :finders]

  has_ancestry

  validates :name, presence: true, uniqueness: true

  def parent_enum
    Category.where.not(id: id).map { |c| [ c.name, c.id ] }
  end
end
