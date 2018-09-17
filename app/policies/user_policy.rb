# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    return true if owner?
  end

  def edit?
    return true if owner?
  end

  def update?
    return true if owner?
  end

  private

  def owner?
    user.present? && user == record
  end
end
