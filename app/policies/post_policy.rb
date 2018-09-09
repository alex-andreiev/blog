# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.present?
  end

  def edit?
    return true if user.present? && user == post.user
  end

  def create?
    user.present?
  end

  def update?
    return true if user.present? && user == post.user
  end

  private

  def post
    record
  end
end
