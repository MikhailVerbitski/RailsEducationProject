class PostsController < ApplicationController
  PERMITTED_PARAMS = %i[body].freeze

  load_and_authorize_resource

  def new
  end

  def create
    if @post.save
      redirect_to @post
    else
      flash.alert = "Can't save!"
    end
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

  private

  def create_params
    params.require(controller_name.classify.downcase.to_sym).permit(self.class::PERMITTED_PARAMS)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
