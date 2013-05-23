# encoding: UTF-8
class Photo < ActiveRecord::Base
  attr_accessible :desc, :image, :score
  mount_uploader :image, ImageUploader

  def url
  end

  def age
  end

  def score_up
  end
end
