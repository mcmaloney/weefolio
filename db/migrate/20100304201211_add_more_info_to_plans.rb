class AddMoreInfoToPlans < ActiveRecord::Migration
  def self.up
    add_column :plans, :card_last_four, :string
    add_column :plans, :gateway_response, :string
    add_column :plans, :payment_status, :string
    add_column :plans, :amount_in_cents, :integer
  end

  def self.down
    remove_column :plans, :card_last_four
    remove_column :plans, :gateway_response
    remove_column :plans, :payment_status
    remove_column :plans, :amount_in_cents
  end
end
