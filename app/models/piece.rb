class Piece < ActiveRecord::Base
  SERVICE_TYPES = ["Design", "Photography", "Studio"]
  acts_as_list
  
  belongs_to :user
  belongs_to :portfolio
  has_many   :image_uploads
  
  validates_presence_of :title
  validates_presence_of :price, :if => :for_sale?
  
  attr_accessible :title, :description, :price, :for_sale, :client_name, :service_type, :sale_url
  
  default_scope :order => :position
  
  def display_price
    "$" + self.price.to_s unless !self.for_sale
  end
  
  def can_add_more_images?
    if self.max_images == self.image_uploads.count
      false
    else
      true
    end
  end
  
  def max_images
    level = Portfolio.find(self.portfolio).account_tier
    case level
    when 1
      1
    when 2
      3
    when 3
      5
    end
  end
  
end
