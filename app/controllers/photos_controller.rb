class PhotosController < ApplicationController
  def index
    @photos = Photo.sorted_young.all
  end
  def update
    @photo = Photo.find(params[:id])
    @photo.score_up
    redirect_to :action => :index
  end
  def new
    @photo = Photo.new
  end
  
  def create
    @photo = Photo.create(params[:photo])
    if @photo.save
      redirect_to action: :index
    else
      render :new
    end
  end
end
