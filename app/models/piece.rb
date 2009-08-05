class Piece < ActiveRecord::Base
  belongs_to :user
  belongs_to :portfolio
  
  validates_presence_of :title
  validates_presence_of :price, :if => :for_sale?
  
  has_attached_file :image_1, :styles => { :small_thumb => "70x70", :large_thumb => "116x116", :full_size => "710x300" }
  has_attached_file :image_2, :styles => { :small_thumb => "70x70", :large_thumb => "116x116", :full_size => "710x300" }
  has_attached_file :image_3, :styles => { :small_thumb => "70x70", :large_thumb => "116x116", :full_size => "710x300" }
  has_attached_file :image_4, :styles => { :small_thumb => "70x70", :large_thumb => "116x116", :full_size => "710x300" }
  has_attached_file :image_5, :styles => { :small_thumb => "70x70", :large_thumb => "116x116", :full_size => "710x300" }
  
  def display_price
    "$" + self.price.to_s unless !self.for_sale
  end
end
