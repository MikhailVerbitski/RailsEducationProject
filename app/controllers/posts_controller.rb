class PostsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    @post = Post.new
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def show
  end

  def index
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
