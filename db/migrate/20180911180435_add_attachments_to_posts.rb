# frozen_string_literal: true

class AddAttachmentsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :attachments, :json
  end
end
