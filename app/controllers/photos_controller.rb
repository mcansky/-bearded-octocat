class PhotosController < ApplicationController
  def index
    @photos = Photo.sorted_young.all
  end
  def update
    @photo = Photo.find(params[:id])
    @photo.score_up
    redirect_to :action => :index
  end
end
