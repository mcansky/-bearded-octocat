class PhotosController < ApplicationController
  def index
    @photos = Photo.sorted_young.all
  end
end
