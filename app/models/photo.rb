# encoding: UTF-8
class Photo < ActiveRecord::Base
  attr_accessible :desc, :image, :score
  mount_uploader :image, ImageUploader
end
