class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :pieces
  
  def account_tier
    self.user.account_tier
  end
  
  def max_pieces
    if self.account_tier == 1
      5
    elsif self.account_tier == 2
      15
    elsif self.account_tier == 3
      25
    end
  end
  
  def can_add_more?
    if self.max_pieces == self.pieces.length
      return false
    else
      return true
    end
  end
end
