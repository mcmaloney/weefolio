class Plan < ActiveRecord::Base
  belongs_to :user
  
  STATUS_OPTIONS = [:none, :pending, :authorized, :charged, :failed]
  
  attr_accessor :authnet_credit_card, :card_number, :card_verification
  
  validate :has_valid_credit_card
  
  before_save :populate_amount_in_cents, :populate_card_last_four
  
  def process_transaction
    if self.valid?
      card = authnet_credit_card
      gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(AUTHORIZE_NET_CREDENTIALS)
      response = gateway.authorize(self.amount_in_cents, card)
      self.gateway_response = response.message
      if response.success?
        self.status = :authorized
        # Capture!
        gateway.capture(self.amount_in_cents, response.authorization)
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
end
