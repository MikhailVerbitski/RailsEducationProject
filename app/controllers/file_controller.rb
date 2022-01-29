require 'fileutils'

class FileController < ApplicationController
  skip_before_action :verify_authenticity_token

  STORAGE = Rails.root.join('tmp/storage')

  def create
    FileUtils.mkdir_p(STORAGE)
    file_name = File.join(STORAGE, params[:userfile].original_filename)
    FileUtils.mv(params[:userfile].tempfile.path, file_name)
  end

  def destroy
  end

  def show
    file_name = File.join(STORAGE, params[:name])
    content = File.open(file_name, 'r', &:read)
    send_data content, type: 'image/jpeg', disposition: 'inline'
  end

  def index
  end
end
