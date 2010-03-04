class Plan < ActiveRecord::Base
  belongs_to :user
  
  BASIC = 0 * 100
  PLUS  = 2.99 * 100
  PRO   = 4.99 * 100
  
  PLAN_OPTIONS = {
    "BASIC" => "Free",
    "PLUS"  => "$2.99",
    "PRO"   => "$4.99"
  }
  
  STATUS_OPTIONS = [:none, :pending, :authorized, :charged, :failed]
  
  attr_accessor :plan_option, :plan_amount_option, :authnet_credit_card
  
  before_save :populate_amount_in_cents
  
  def process_transaction
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
  
  def populate_amount_in_cents
    option = self.class.const_get(self.plan_option)
    self.amount_in_cents = option
  end
  
  def populate_card_last_four
    self.card_last_four = self.card_number.last(4)
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
