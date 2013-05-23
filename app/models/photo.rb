# encoding: UTF-8
class Photo < ActiveRecord::Base
  attr_accessible :desc, :image, :score, :remote_image_url
  mount_uploader :image, ImageUploader

  scope :young, lambda { where("created_at > ?", Time.zone.now - 7.days ) }
  scope :sorted_young, young.order("score DESC")

  def url
    image.blank? ? nil : image.url
  end

  def age
    Time.now - created_at
  end

  def score_up
    self.score += 1
    self.save
  end

  def young?
    true if age < 7.days
  end

  def old?
    !young?
  end
end
