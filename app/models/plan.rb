class Plan < ActiveRecord::Base
  belongs_to :user
  
  PLUSAMOUNT = 2.99 * 100
  PROAMOUNT  = 4.99 * 100
  
  PLAN_OPTIONS = {
    "BASIC" => "Free",
    "PLUS"  => "$2.99",
    "PRO"   => "$4.99"
  }
  
  attr_accessor :plan_option
  
  def process_transaction
    gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(AUTHORIZE_NET_CREDENTIALS)
  end
end
