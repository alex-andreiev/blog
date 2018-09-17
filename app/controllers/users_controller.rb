# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    @user.update(user_params)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
