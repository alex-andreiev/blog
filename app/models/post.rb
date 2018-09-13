# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImageUploader
  mount_uploaders :attachments, ImageUploader

  validates :title, :body, presence: true
  validates :image, file_size: { less_than: 1.megabytes }

  self.per_page = 10
end
