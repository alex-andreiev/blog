# frozen_string_literal: true

module PagesHelper
  def posted_date(datetime)
    l(datetime, format: :created_date)
  end

  def posted_time(datetime)
    l(datetime, format: :created_time)
  end

  def show_image(image, style)
    image_url = image.url || 'http://placehold.it/750x300'
    image_tag(image_url, class: style)
  end
end
