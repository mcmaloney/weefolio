class Piece < ActiveRecord::Base
  belongs_to :user
  belongs_to :portfolio
  
  attr_accessor :image_1_file_name, :image_2_file_name, :image_3_file_name, :image_4_file_name, :image_5_file_name
  
  has_attached_file :image_1
  has_attached_file :image_2
  has_attached_file :image_3
  has_attached_file :image_4
  has_attached_file :image_5
end
