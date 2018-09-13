# frozen_string_literal: true

class Post < ApplicationRecord
  extend FriendlyId
  extend FriendlyId::Finders
  friendly_id :slug, use: [:slugged, :finders]

  belongs_to :user

  mount_uploader :image, ImageUploader
  mount_uploaders :attachments, ImageUploader

  validates :title, :body, presence: true
  validates :image, file_size: { less_than: 1.megabytes }

  self.per_page = 10

  def generate_slug_name
    "#{title}".downcase.gsub(/[^a-z0-9]/i, '-')
  end
end
