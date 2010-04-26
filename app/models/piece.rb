class Piece < ActiveRecord::Base
  SERVICE_TYPES = ["Design", "Photography", "Studio"]
  acts_as_list
  
  belongs_to :user
  belongs_to :portfolio
  
  validates_presence_of :title
  validates_presence_of :price, :if => :for_sale?
  
  attr_accessible :title, :description, :image_1, :image_2, :image_3, :image_4, :image_5, :price, :for_sale, :client_name, :service_type, :sale_url
  
  default_scope :order => :position
  
  # I know, I know. We should really put the paperclip stuff in an initializer or something. We'll get there...
  
  has_attached_file :image_1, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x710>" },
                                            :storage => :s3, 
                                            :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                                            :path => ':attachment/:id/:style/:basename.:extension',
                                            :bucket => 'weefolio'
  has_attached_file :image_2, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x710>" },
                                            :storage => :s3, 
                                            :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                                            :path => ':attachment/:id/:style/:basename.:extension',
                                            :bucket => 'weefolio'
  has_attached_file :image_3, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x710>" },
                                            :storage => :s3, 
                                            :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                                            :path => ':attachment/:id/:style/:basename.:extension',
                                            :bucket => 'weefolio'
  has_attached_file :image_4, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x710>" },
                                            :storage => :s3, 
                                            :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                                            :path => ':attachment/:id/:style/:basename.:extension',
                                            :bucket => 'weefolio'
  has_attached_file :image_5, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x710>" },
                                            :storage => :s3, 
                                            :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                                            :path => ':attachment/:id/:style/:basename.:extension',
                                            :bucket => 'weefolio'
  
  def display_price
    "$" + self.price.to_s unless !self.for_sale
  end
  
  def images
    images = [self.image_1, self.image_2, self.image_3, self.image_4, self.image_5]
  end
  
  def number_of_images
  	n = 0
  	self.images.each do |image|
  		if !image.size.blank?
  			n += 1
  		end
  	end
  	n
  end
end
