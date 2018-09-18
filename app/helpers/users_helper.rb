# frozen_string_literal: true

module UsersHelper
  def render_username(user)
    user.full_name.blank? ? user.login : user.full_name
  end
end
