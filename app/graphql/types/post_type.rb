# frozen_string_literal: true

class Types::PostType < Types::BaseObject
  field :id, ID, null: false
  field :title, String, null: true
  field :body, String, null: true
  field :user_id, ID, null: true
end
