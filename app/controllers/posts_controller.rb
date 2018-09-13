# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update]

  def index
    @posts ||= Post.all.includes(:user).paginate(page: params[:page]).order('created_at DESC')
    authorize @posts
  end

  def show
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    authorize @post

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:id,
                                 :title,
                                 :body,
                                 :user_id,
                                 :remove_image,
                                 :remote_image_url,
                                 :image, attachments: [])
  end
end
