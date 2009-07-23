class Piece < ActiveRecord::Base
  belongs_to :user
  belongs_to :portfolio
  
  validates_presence_of :price, :if => :for_sale?
  
  has_attached_file :image_1
  has_attached_file :image_2
  has_attached_file :image_3
  has_attached_file :image_4
  has_attached_file :image_5
  
  def display_price
    "$" + self.price.to_s unless !self.for_sale
  end
end
