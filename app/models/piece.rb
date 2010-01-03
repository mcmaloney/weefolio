class Piece < ActiveRecord::Base
  acts_as_list
  
  belongs_to :user
  belongs_to :portfolio
  
  validates_presence_of :title
  validates_presence_of :price, :if => :for_sale?
  
  attr_accessible :title, :description, :image_1, :image_2, :image_3, :image_4, :image_5, :price, :for_sale
  
  default_scope :order => :position
  
  has_attached_file :image_1, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x300#" }
  has_attached_file :image_2, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x300#" }
  has_attached_file :image_3, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x300#" }
  has_attached_file :image_4, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x300#" }
  has_attached_file :image_5, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x300#" }
  
  def display_price
    "$" + self.price.to_s unless !self.for_sale
  end
  
  def images
    images = [self.image_1, self.image_2, self.image_3, self.image_4, self.image_5]
  end
end
