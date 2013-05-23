class Photo < ActiveRecord::Base
  attr_accessible :desc, :image, :score
end
