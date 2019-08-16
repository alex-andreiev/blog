# frozen_string_literal: true

module Queries::PostQueries
  extend ActiveSupport::Concern

  included do
    field :post, Types::PostType, null: false do
      description 'Retrieve post'
      argument :id, String, required: true
    end

    def post(id:)
      Post.where(published: true).find(id)
    end
  end
end
