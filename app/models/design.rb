class Design < ActiveRecord::Base
  belongs_to :user
  
  def design_type
    self.user.design_type
  end
end
