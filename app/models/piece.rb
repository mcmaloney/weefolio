class Piece < ActiveRecord::Base
  belongs_to :user
  belongs_to :portfolio
  
  has_attached_file :image_1
  has_attached_file :image_2
  has_attached_file :image_3
  has_attached_file :image_4
  has_attached_file :image_5
end
