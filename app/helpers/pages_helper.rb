# frozen_string_literal: true

module PagesHelper
  def posted_date(post)
    l(post.created_at, format: :created_post)
  end

  def show_image(image)
    image_url = image.url || 'http://placehold.it/750x300'
    image_tag(image_url, class: 'card-img-top')
  end
end
