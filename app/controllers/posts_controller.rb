class PostsController < ApplicationController
  PERMITTED_PARAMS = %i[body].freeze

  load_and_authorize_resource

  def new
  end

  def edit
  end

  def show
  end

  def create
    if @post.save
      redirect_to @post
    else
      flash.alert = "Can't save!"
    end
  end

  def update
    if @post.update(create_params)
      redirect_to @post
    else
      flash.alert = "Can't Update!"
    end
  end

  def destroy
    @post.delete
    redirect_to root_url, notice: 'Post deleted'
  end

  def index
    @posts = Post.all
  end

  private

  def create_params
    params.require(controller_name.classify.downcase.to_sym).permit(self.class::PERMITTED_PARAMS)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
