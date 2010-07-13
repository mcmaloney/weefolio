class ImageUpload < ActiveRecord::Base
  belongs_to :piece
  has_attached_file :image, :styles => { :small_thumb => "70x70#", :large_thumb => "116x116#", :full_size => "710x710>" },
                                            :storage => :s3, 
                                            :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                                            :path => ':attachment/:id/:style/:basename.:extension',
                                            :bucket => 'weefolio'
                                            
                                            
  validates_presence_of :image
end
