class Plan < ActiveRecord::Base
  require 'active_merchant'
  belongs_to :user
  
  STATUS_OPTIONS = [:none, :pending, :authorized, :charged, :failed]
  
  attr_accessor :authnet_credit_card, :card_number, :card_verification
  
  validate :has_valid_credit_card
  
  before_save :populate_amount_in_cents, :populate_card_last_four
  
  # def process_transaction
  #    if self.valid?
  #      card = authnet_credit_card
  #      gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(AUTHORIZE_NET_CREDENTIALS)
  #      response = gateway.authorize(self.amount_in_cents, card)
  #      self.gateway_response = response.message
  #      if response.success?
  #        self.status = :authorized
  #        # Capture!
  #        gateway.capture(self.amount_in_cents, response.authorization)
  #        self.status = :charged
  #        return true
  #      else
  #        self.status = :failed
  #        return false
  #      end
  #    else
  #      self.status = :failed
  #      return false
  #    end
  #  end
  
  
  def process_transaction
    if self.valid?
      card = authnet_credit_card
      gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(AUTHORIZE_NET_CREDENTIALS)
      response = gateway.recurring(self.amount_in_cents, 
                                   card, :billing_address => {:address1 => self.billing_address,
                                                              :address2 => self.billing_address_2,
                                                              :city => self.billing_city, 
                                                              :state => self.billing_state, 
                                                              :zip => self.billing_postal_code, 
                                                              :country => "US", 
                                                              :first_name => self.billing_first_name, 
                                                              :last_name => self.billing_last_name}, 
                                         :interval => {:unit => :months, :length => 12}, 
                                         :duration => {:start_date => Date.today.strftime('%Y-%m-%d'), :occurrences => 9999}, 
                                         :customer => {:id => "#{self.user_id}-#{Time.now.to_i.to_s[-4,4]}"})
      self.gateway_response = response.message
      if response.success?
        self.status = :charged
        return true
      else
        self.status = :failed
        return false
      end
    else
      self.status = :failed
      return false
    end  
  end
  
  
  # Returns an authnet credit card instance.
  def authnet_credit_card
    @authnet_credit_card ||= ActiveMerchant::Billing::CreditCard.new({
      :type => self.card_type,
      :number => self.card_number,
      :month => self.card_expiration_month,
      :year => self.card_expiration_year,
      :first_name => self.billing_first_name,
      :last_name => self.billing_last_name,
      :verification_value => self.card_verification
    })
  end
  
  def has_valid_credit_card
    card = authnet_credit_card
    if card.valid?
      true
    else
      errors.add_to_base("Credit card invalid – please verify that your billing information matches your credit card statement and verify your credit card account number and security code.")
    end
  end
  
  def populate_amount_in_cents
    if self.level == 1
      self.amount_in_cents = 0
    elsif self.level == 2
      self.amount_in_cents = 299
    elsif self.level == 3
      self.amount_in_cents = 499
    end
  end
  
  def populate_card_last_four
    self.card_last_four = self.card_number.last(4) unless self.card_number.blank?
  end
  
  # Check with authnet to see if the card is valid.
  def valid_cc?
    self.authnet_credit_card.valid?
  end
  
  def status
    (self.payment_status ||= 'none').to_sym
  end
  
  def status=(s)
     raise ArgumentError unless STATUS_OPTIONS.include?(s)
     self.payment_status = s.to_s
   end
  
  def has_valid_credit_card
    card = authnet_credit_card
    if card.valid?
      true
    else
      errors.add_to_base("Credit card invalid – please verify that your billing information matches your credit card statement and verify your credit card account number and security code.")
    end
  end
  
  # If I have 6 pieces, I can't downgrade from level 2 to level 1...
  def can_downgrade_to(requested_level)
    if User.find(self.user_id).portfolio.pieces.length > Portfolio.max_pieces_for(requested_level)
      return false
    else
      return true
    end
  end
  
  # How many pieces do I have to delete to downgrade to the requested level?
  def delete_pieces_for(requested_level)
    User.find(self.user_id).portfolio.pieces.length - Portfolio.max_pieces_for(requested_level)
  end
  
  
end
